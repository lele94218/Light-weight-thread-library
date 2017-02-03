#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

/* Global variable */

/* used for assigning thread id */
int lwt_counter = 0;
int thread_initiated = 0;

/* two queues, one for thread either waiting or running, one for recycling */
linked_list * valid_queue;
linked_list * recycle_queue;
linked_list * zombie_queue;

/* identify threads */
lwt_t  current_thread;
lwt_t  old_thread;


/* internal function declaration */
/* functions for thread operation */
void __lwt_dispatch(lwt_context *curr, lwt_context *next);
void __lwt_schedule (void);
lwt_t  __create_thread(int with_stack, lwt_fn_t fn, void * data);
lwt_t  __reuse_thread(lwt_fn_t fn, void * data);
void *__lwt_trampoline();
static void __initiate(void);
linked_list * __init_list();

/* thread queue functions declarartion */
lwt_t  __get_active_thread (linked_list * thread_queue);
int __add_to_tail(lwt_t  thread, linked_list * thread_queue);
int __add_to_head(lwt_t  thread, linked_list * thread_queue);
int __remove_from_queue(lwt_t  thread, linked_list * thread_queue);

/* add a thread to tail of a thread queue */
int
__add_to_tail (lwt_t  thread, linked_list * thread_queue)
{
	thread->next = NULL;
	thread->prev = NULL;

	if (!thread_queue->node_count)
	{
		thread_queue->head = thread;
		thread_queue->tail = thread;
	}

	else
	{
	thread_queue->tail->next = thread;
	thread->prev = thread_queue->tail;
	thread_queue->tail = thread;
	}

	++ thread_queue->node_count;
	return thread_queue->node_count - 1;
}

int
__add_to_head (lwt_t  thread, linked_list * thread_queue)
{
	thread->next = NULL;
	thread->prev = NULL;

	if (!thread_queue->node_count)
	{
		thread_queue->head = thread;
		thread_queue->tail = thread;
	}

	else
	{
	thread_queue->head->prev = thread;
	thread->next = thread_queue->head;
	thread_queue->head = thread;
	}

	++ thread_queue->node_count;
	return thread_queue->node_count - 1;
}

/* remove a thread from queue */
int
__remove_from_queue(lwt_t  thread, linked_list * thread_queue)
{
	lwt_t  tmp_thread=thread_queue->head;
	if (thread_queue->node_count==0) return -1;
	while(tmp_thread)
	{
		if (tmp_thread==thread)
		{
			if(thread_queue->node_count==1)
			{
				thread_queue->head=NULL;
				thread_queue->tail=NULL;
				thread_queue->node_count--;
				return 0;
			}
			if(thread_queue->head==tmp_thread)
			{
				thread_queue->head=tmp_thread->next;
				if (tmp_thread->next)
					tmp_thread->next->prev=NULL;
				thread_queue->node_count--;
				return 0;
			}
			if(thread_queue->tail==tmp_thread)
			{
				thread_queue->tail=tmp_thread->prev;
				if (tmp_thread->prev)
					tmp_thread->prev->next=NULL;
				thread_queue->node_count--;
				return 0;
			}
			if (tmp_thread->prev)
				tmp_thread->prev->next=tmp_thread->next;
			if (tmp_thread->next)
				tmp_thread->next->prev=tmp_thread->prev;
			thread_queue->node_count--;
			return 0;
		}
		tmp_thread=tmp_thread->next;
	}
	#ifdef DEBUG
	printf("thread to be removed not found!\n");
	#endif
	return -1;
}

/* get a thread that is with highest priority (at the head of queue). */
lwt_t 
__get_active_thread (linked_list * thread_queue)
{
	lwt_t  curr = thread_queue->head;
	while (curr)
	{
		if (curr->status == LWT_INFO_NTHD_RUNNABLE)
		{
			return curr;
		}
		curr = curr->next;
	}
    return NULL;
}

/* pause one thread, start executing the next one */
void __lwt_dispatch(lwt_context *curr, lwt_context *next)
{
__asm__ __volatile
	(
	//"push %edi\n\t"
        //"push %esi\n\t"
	//"push %ebx\n\t"
	"mov 0xc(%ebp),%eax\n\t"
	"mov 0x4(%eax),%ecx\n\t"
	"mov (%eax),%edx\n\t"
	"mov 0x8(%ebp),%eax\n\t"
	"add $0x4,%eax\n\t"
	"mov 0x8(%ebp),%ebx\n\t"
	"push %ebp\n\t"
	//"push %eax\n\t"
	"push %ebx\n\t"
	//"push %ecx\n\t"
	//"push %edx\n\t"
	"mov %esp,(%eax)\n\t"
	"movl $return,(%ebx)\n\t"
	"mov %ecx,%esp\n\t"
	"jmp *%edx\n\t"
	//"return: pop %edx\n\t"
	//"pop %ecx\n\t"
	"return: pop %ebx\n\t"
	//"pop %eax\n\t"
	"pop %ebp\n\t"
	//"pop %ebx\n\t"
	//"pop %esi\n\t"
	//"pop %edi\n\t"
	);
}

/* find one proper thread to execute from pool */
void
__lwt_schedule ()
{
	old_thread=current_thread;
	current_thread = __get_active_thread(valid_queue);
	if (current_thread==old_thread)
	{
		return;
	}
	if (current_thread)
	{
		#ifdef DEBUG
		printf("thread %d start executing from reschedule\n", current_thread->lwt_id);
		#endif
		__lwt_dispatch(&old_thread->context, &current_thread->context);
	}
	else 
	{
		#ifdef DEBUG
		printf("error in getting a valid thread from queue \n");
		#endif
		return;
	}
}

/* create and initialize a thread */
lwt_t  __create_thread(int with_stack, lwt_fn_t fn, void * data)
{
	lwt_t  created_thread=(lwt_t) malloc (sizeof(struct _lwt_t));
	created_thread->lwt_id = lwt_counter ++;
	created_thread->status = LWT_INFO_NTHD_RUNNABLE;
	created_thread->next=NULL;
	created_thread->prev=NULL;
	created_thread->merge_to=NULL;
	created_thread->wait_merge=NULL;
	created_thread->last_word=NULL;
	if (with_stack)
	{
		/* init stack with die function */
    		uint _sp = (uint) malloc(MAX_STACK_SIZE);
		created_thread->init_sp=_sp;
    		_sp += (MAX_STACK_SIZE - sizeof(uint));
    		*((uint *)_sp) = (uint)data;
    		_sp -= (sizeof(uint));
    		*((uint *)_sp) = (uint)fn;
		_sp -= (sizeof(uint));
		created_thread->context.sp = _sp;
    		created_thread->context.ip = (uint) __lwt_trampoline;
	}
	#ifdef DEBUG
	printf("create thread %d complete\n", created_thread->lwt_id);
	#endif
	return created_thread;
}

/* reuse a thread from recycle_queue instead of create */
lwt_t 
__reuse_thread(lwt_fn_t fn, void * data)
{
	lwt_t  reused_thread=recycle_queue->head;
	__remove_from_queue(reused_thread, recycle_queue);
	reused_thread->lwt_id = lwt_counter ++;
	reused_thread->status = LWT_INFO_NTHD_RUNNABLE;
	reused_thread->next=NULL;
	reused_thread->prev=NULL;
	reused_thread->merge_to=NULL;
	reused_thread->wait_merge=NULL;
	reused_thread->last_word=NULL;
	#ifdef DEBUG
	printf("create thread %d from recycle\n", reused_thread->lwt_id);
	#endif
	uint _sp=reused_thread->init_sp;
	_sp += (MAX_STACK_SIZE - sizeof(uint));
	*((uint *)_sp) = (uint)data;
	_sp -= (sizeof(uint));
    	*((uint *)_sp) = (uint)fn;
	_sp -= (sizeof(uint));
	reused_thread->context.sp = _sp;
	reused_thread->context.ip = (uint) __lwt_trampoline;
	return reused_thread;
}

/* initialize main thread and the queues when user called create at first time */
static void
__initiate()
{
	thread_initiated = 1;
	current_thread = __create_thread(0, (void *)NULL, NULL);
	/* initialize valid_queue */
	valid_queue=__init_list();
	/* initialize recycle queue */
	recycle_queue=__init_list();
	/* initialize zombie_queue */
	zombie_queue=__init_list();
	__add_to_tail(current_thread,valid_queue);
	#ifdef DEBUG
	printf("initialization complete\n");
	#endif
}

linked_list * __init_list()
{
	linked_list * list=(linked_list *)malloc(sizeof(linked_list));
	list->node_count=0;
	list->head=NULL;
	list->tail=NULL;
	return list;
}

/* create a thread, return its lwt_t pointer */
lwt_t 
lwt_create(lwt_fn_t fn, void * data)
{
	if(!thread_initiated) __initiate();
	lwt_t  next_thread;
	/* decide if re-use from recycle queue */
	next_thread=recycle_queue->node_count? __reuse_thread(fn, data) :__create_thread(1, fn, data);
	#ifdef DEBUG
	printf("thread: %d has created thread: %d\n", current_thread->lwt_id,next_thread->lwt_id);
	#endif
	__add_to_tail(next_thread,valid_queue);
	return next_thread;
}

/* mark as zombie, put to recycle, merge to other waiting threads and deliver the messsage to them */
void
lwt_die(void * message)
{
	#ifdef DEBUG
	printf("die function start executing for thread %d.\n",current_thread->lwt_id);
	#endif
	current_thread->last_word=message;
	/* if someone is waiting to join this one */
	if (current_thread->merge_to)
	{
		current_thread->merge_to->status=LWT_INFO_NTHD_RUNNABLE;
		current_thread->merge_to->last_word=message;
		current_thread->merge_to=NULL;
		current_thread->status=LWT_INFO_NTHD_ZOMBIES;
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, recycle_queue);
		#ifdef DEBUG
		printf("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
		#endif
	}
	/* nobody is currently waiting to join this one */
	else
	{
		current_thread->status=LWT_INFO_NTHD_ZOMBIES;
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, zombie_queue);
		#ifdef DEBUG
		printf("removed dead thread %d to zombie queue\n", current_thread->lwt_id);
		#endif
	}

	/* go die, pass flow to another thread */
	__lwt_schedule();
}

/* when thread ends from beginning function, extract return value and ready to kill the thread */
void * 
__lwt_trampoline(lwt_fn_t fn, void * data)
{
	void * return_message=fn(data);
	#ifdef DEBUG
	printf("thread %d ready to die, with last word %d\n",current_thread->lwt_id,(int)return_message);
	#endif
	lwt_die(return_message);
}

/* put the thread to queue end, allow others to execute, if argument has a value, yield to a specific thread */
int
lwt_yield(lwt_t  strong_thread)
{
	/* yield to NULL */
	if (!strong_thread)
	{
		#ifdef DEBUG
		printf("thread %d has yielded\n", current_thread->lwt_id);
		#endif
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, valid_queue);
		//print_thread_info();
		__lwt_schedule();
		return 0;
	}
	if (strong_thread==current_thread)
	{
		#ifdef DEBUG
		printf("thread %d is yielding to itself...\n",current_thread->lwt_id);
		#endif
		return 0;
	}
	if (strong_thread->status!=LWT_INFO_NTHD_RUNNABLE)
	{
		#ifdef DEBUG
		printf("thread %d is yielding to a thread not runnable...\n",current_thread->lwt_id);
		#endif
		return 0;
	}
	__remove_from_queue(current_thread, valid_queue);
	__add_to_tail(current_thread, valid_queue);
	__remove_from_queue(strong_thread, valid_queue);
	__add_to_head(strong_thread, valid_queue);
	__lwt_schedule();
	return 0;
}

/* blocked and wait for the argument thread, when argument thread ends, resume execution and return message from the dead thread */
void *
lwt_join(lwt_t  thread_to_wait)
{

	if(thread_to_wait==NULL)
	{
		#ifdef DEBUG
		printf("error: current thread is waiting for a thread does not exists");
		#endif
		return NULL;
	}
	else if(thread_to_wait->status==LWT_INFO_NTHD_ZOMBIES)
	{
		#ifdef DEBUG
		printf("error: current thread is waiting for a dead thread\n");
		#endif
		__remove_from_queue(current_thread, zombie_queue);
		__add_to_tail(current_thread, recycle_queue);
		return thread_to_wait->last_word;
	}
	else if(thread_to_wait==current_thread)
	{
		#ifdef DEBUG
		printf("error: a thread cannot join itself");
		#endif
		return NULL;
	}
	else if(thread_to_wait->merge_to!=NULL)
	{
		#ifdef DEBUG
		printf("error: cannot join a thread that is been reserved by others");
		#endif
		return NULL;
	}
	/* update both thread */
	current_thread->wait_merge=thread_to_wait;
	thread_to_wait->merge_to=current_thread;
	#ifdef DEBUG
	printf("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
	#endif
	current_thread->status=LWT_INFO_NTHD_BLOCKED;
	__remove_from_queue(current_thread, valid_queue);
	__add_to_tail(current_thread, valid_queue);
	__lwt_schedule();
	#ifdef DEBUG
	printf("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, current_thread->wait_merge->lwt_id, (int)current_thread->last_word);
	#endif
	current_thread->wait_merge=NULL;
	return current_thread->last_word;
}

/* return current active thread */
lwt_t 
lwt_current()
{
	if(!thread_initiated) __initiate();
	return current_thread;
}

/* return the id of a thread */
int
lwt_id(lwt_t  input_thread)
{
	return current_thread->lwt_id;
}

/* internal test function, out put the valid queue and its thread status */
void
test_thread_queue()
{
	lwt_t  current=valid_queue->head;
	while(current!=NULL)
	{
		#ifdef DEBUG
		printf("thread queue id: %d\n", current->lwt_id);
		#endif
		current=current->next;
	}
}

/* internal test function, out put the valid queue and its thread status */
void
print_living_thread_info()
{
	#ifdef DEBUG
	printf("there are %d living thread, status shows as below:\n", valid_queue->node_count);
	#endif
	lwt_t  current=valid_queue->head;
	while(current!=NULL)
	{
		#ifdef DEBUG
		printf("thread: %d in valid queue with status %d\n", current->lwt_id,current->status);
		#endif
		current=current->next;
	}
	//printf("dead thread recycle queue contains %d items\n", recycle_queue->node_count);
}

void
print_dead_thread_info()
{
	#ifdef DEBUG
	printf("there are %d dead thread, status shows as below:\n", recycle_queue->node_count);
	#endif
	lwt_t  current=recycle_queue->head;
	while(current!=NULL)
	{
		#ifdef DEBUG
		printf("thread: %d in dead queue with status %d\n", current->lwt_id,current->status);
		#endif
		current=current->next;
	}
}


int
lwt_info(lwt_info_t t)
{
	if (t == LWT_INFO_NTHD_ZOMBIES)
		return zombie_queue->node_count;	

	int cnt = 0;
	
	lwt_t current = valid_queue->head;
	while (current)
	{
		if (current->status == t) cnt ++;
		current = current->next;
	}
	return cnt;
}
