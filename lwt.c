#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

/* Global variable */
/* used for assigning thread id */
int lwt_counter = 0;
int thread_initiated = 0;

/* three queues, one for thread either waiting or running, one for zombies, one for recycle */
linked_list * valid_queue;
linked_list * recycle_queue;
linked_list * zombie_queue;

/* identify threads */
lwt_t  current_thread;
lwt_t  old_thread;


/* internal function declaration, below functions are only used internally */
/* functions for thread operation */
inline void __lwt_dispatch(lwt_context *curr, lwt_context *next);
void __lwt_schedule (void);
lwt_t  __create_thread(int with_stack, lwt_fn_t fn, void * data);
void __init_thread(lwt_t created_thread);
void __init_stack(lwt_t thread, lwt_fn_t fn, void * data);
lwt_t  __reuse_thread(lwt_fn_t fn, void * data);
void *__lwt_trampoline();
void __initiate(void);
linked_list * __init_list();

/* thread queue functions declarartion */
lwt_t  __get_active_thread (linked_list * thread_queue);
void __add_to_tail(lwt_t  thread, linked_list * thread_queue);
void __add_to_head(lwt_t  thread, linked_list * thread_queue);
void __remove_from_queue(lwt_t, linked_list *);

/* add a thread to tail of a thread queue */
	void
__add_to_tail (lwt_t thread, linked_list * thread_queue)
{
	thread->next = NULL;
	thread->prev = NULL;
	if (thread_queue->node_count)
	{
		thread_queue->tail->next = thread;
		thread->prev = thread_queue->tail;
		thread_queue->tail = thread;
	}
	else
	{
		thread_queue->head = thread;
		thread_queue->tail = thread;
	}
	++ thread_queue->node_count;
	return;
}

/* add a thread to head of a thread queue */
	void
__add_to_head (lwt_t  thread, linked_list * thread_queue)
{
	thread->next = NULL;
	thread->prev = NULL;
	if (thread_queue->node_count)
	{
		thread_queue->head->prev = thread;
		thread->next = thread_queue->head;
		thread_queue->head = thread;
	}
	else
	{
		thread_queue->head = thread;
		thread_queue->tail = thread;
	}
	++ thread_queue->node_count;
	return;
}

/* remove a thread from a queue */
	void
__remove_from_queue(lwt_t thread, linked_list * list)
{
	if (list->node_count==1)
	{
		list->head = NULL;
		list->tail = NULL;
	}
	else if (thread==list->head)
	{
		list->head = thread->next;
		thread->next->prev = NULL;
	}
	else if (thread == list->tail)
	{
		list->tail = thread->prev;
		thread->prev->next = NULL;
	}
	else
	{
		thread->prev->next = thread->next;
		thread->next->prev = thread->prev;
	}
	list->node_count --;
	return;
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
inline void __lwt_dispatch(lwt_context *curr, lwt_context *next)
{
	__asm__ __volatile__
		(
#ifdef SAFE_MODE
		 "push %%ebx;"
		 "push %%esi;"
		 "push %%edi;"
#endif
		 "movl %%esp,%0;"
		 "movl $retDispatch%=,%1;"
		 "movl %2,%%esp;"
		 "jmp *%3;"
		 "retDispatch%=:;"
#ifdef SAFE_MODE
		 "pop %%edi;"
		 "pop %%esi;"
		 "pop %%ebx;"
#endif
		 :"=m" (curr->sp),"=m" (curr->ip)
		 :"m"(next->sp),"m" (next->ip)
		 :
		);
}

/* find one proper thread to execute from pool */
	void
__lwt_schedule ()
{
	old_thread=current_thread;
	current_thread = __get_active_thread(valid_queue);
	if (current_thread&&current_thread!=old_thread)
	{
                DEBUG("thread %d start executing from reschedule\n", current_thread->lwt_id);
		__lwt_dispatch(&old_thread->context, &current_thread->context);
		return;
	}
	else
	{
		current_thread=old_thread;
		DEBUG("thread %d cannot find a valid thread to dispatch, keep executing\n",current_thread->lwt_id);
		return;
	}
}

/* create and initialize a thread */
lwt_t __create_thread(int with_stack, lwt_fn_t fn, void * data)
{
	lwt_t  created_thread=(lwt_t) malloc (sizeof(struct _lwt_t));
	__init_thread(created_thread);
	/* create a stack for the thread */
	if (with_stack)
	{
		/* init stack with die function */
		created_thread->init_sp= (uint) malloc(MAX_STACK_SIZE);
		__init_stack(created_thread, fn, data);
	}
	DEBUG("create thread %d complete\n", created_thread->lwt_id);
	return created_thread;
}

/* reuse a thread from recycle_queue instead of create */
	lwt_t
__reuse_thread(lwt_fn_t fn, void * data)
{
	lwt_t reused_thread=recycle_queue->head;
	__remove_from_queue(reused_thread, recycle_queue);
	__init_thread(reused_thread);
<<<<<<< HEAD
	DEBUG("create thread %d from recycle\n", reused_thread->lwt_id);
	uint _sp=reused_thread->init_sp;
	_sp += (MAX_STACK_SIZE - sizeof(uint));
	*((uint *)_sp) = (uint)data;
	_sp -= (sizeof(uint));
	*((uint *)_sp) = (uint)fn;
	_sp -= (sizeof(uint));
	reused_thread->context.sp = _sp;
	reused_thread->context.ip = (uint) __lwt_trampoline;
=======
#ifdef DEBUG_MODE
	printf("create thread %d from recycle\n", reused_thread->lwt_id);
#endif
	__init_stack(reused_thread, fn, data);
>>>>>>> 1a32f744a955dfca6bdfcb78a1b149f94de744fb
	return reused_thread;
}

/* init a struct of lwt */
void __init_thread(lwt_t created_thread)
{
	created_thread->lwt_id = lwt_counter ++;
	created_thread->status = LWT_INFO_NTHD_RUNNABLE;
	created_thread->next = NULL;
	created_thread->prev = NULL;
	created_thread->merge_to = NULL;
	created_thread->wait_merge = NULL;
	created_thread->last_word = NULL;
}

/* init a stack */
void __init_stack(lwt_t thread, lwt_fn_t fn, void * data)
{
	thread->context.sp = thread->init_sp;
	thread->context.sp += (MAX_STACK_SIZE - sizeof(uint));
	*((uint *)thread->context.sp) = (uint)data;
	thread->context.sp -= (sizeof(uint));
	*((uint *)thread->context.sp) = (uint)fn;
	thread->context.sp -= (sizeof(uint));
	thread->context.ip = (uint) __lwt_trampoline;
}


/* initialize main thread and the queues when user called create at first time */
	void
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
	DEBUG("initialization complete\n");
}

linked_list * __init_list()
{
	linked_list * list = (linked_list *)malloc(sizeof(linked_list));
	list->node_count = 0;
	list->head = NULL;
	list->tail = NULL;
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
	DEBUG("thread: %d has created thread: %d\n", current_thread->lwt_id,next_thread->lwt_id);
	__add_to_tail(next_thread,valid_queue);
	return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
	void
lwt_die(void * message)
{
	DEBUG("die function start executing for thread %d.\n",current_thread->lwt_id);
	current_thread->last_word=message;
	/* if someone is waiting to join this one, return and go to recycle queue */
	if (current_thread->merge_to)
	{
		current_thread->merge_to->status = LWT_INFO_NTHD_RUNNABLE;
		current_thread->merge_to->last_word = message;
		current_thread->merge_to = NULL;
		current_thread->status = LWT_INFO_NTHD_ZOMBIES;
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, recycle_queue);
		DEBUG("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
	}
	/* nobody is currently waiting to join this one, becomes a zombie */
	else
	{
		current_thread->status = LWT_INFO_NTHD_ZOMBIES;
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, zombie_queue);
		DEBUG("removed dead thread %d to zombie queue\n", current_thread->lwt_id);
	}

	/* go die, pass flow to another thread */
	__lwt_schedule();
}

/* start a thread, execute its function, get return value and ready to kill the thread */
	void *
__lwt_trampoline(lwt_fn_t fn, void * data)
{
	void * return_message = fn(data);
	DEBUG("thread %d ready to die, with last word %d\n", current_thread->lwt_id,(int)return_message);
	lwt_die(return_message);
}

/* put the thread to run queue end, allow others to execute, if argument has a value, yield to a specific thread */
	int
lwt_yield(lwt_t strong_thread)
{
	/* yield to NULL */
	if (!strong_thread)
	{
		DEBUG("thread %d has yielded\n", current_thread->lwt_id);
		__remove_from_queue(current_thread, valid_queue);
		__add_to_tail(current_thread, valid_queue);
		__lwt_schedule();
		return 0;
	}
#ifdef SAFE_MODE
	/* yield to itself */
	if (strong_thread == current_thread)
	{
		DEBUG("thread %d is yielding to itself...\n",current_thread->lwt_id);
		return 0;
	}
	/* yield to something not runnable */
	if (strong_thread->status != LWT_INFO_NTHD_RUNNABLE)
	{
		DEBUG("thread %d is yielding to a thread not runnable...\n",current_thread->lwt_id);
		return 0;
	}
#endif
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
#ifdef SAFE_MODE
	if(thread_to_wait == NULL)
	{
		DEBUG("error: current thread is waiting for a thread does not exists");
		return NULL;
	}
	else if(thread_to_wait == current_thread)
	{
		DEBUG("error: a thread cannot join itself");
		return NULL;
	}
	else if(thread_to_wait->merge_to != NULL)
	{
		DEBUG("error: cannot join a thread that is been reserved by others");
		return NULL;
	}
#endif
	if(thread_to_wait->status == LWT_INFO_NTHD_ZOMBIES)
	{
		DEBUG("current thread is collecting a zombie thread\n");
		__remove_from_queue(thread_to_wait, zombie_queue);
		__add_to_tail(thread_to_wait, recycle_queue);
		return thread_to_wait->last_word;
	}
	/* update both thread */
	current_thread->wait_merge = thread_to_wait;
	thread_to_wait->merge_to = current_thread;
	DEBUG("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
	current_thread->status = LWT_INFO_NTHD_BLOCKED;
	__remove_from_queue(current_thread, valid_queue);
	__add_to_tail(current_thread, valid_queue);
	__lwt_schedule();
	DEBUG("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, current_thread->wait_merge->lwt_id, (int)current_thread->last_word);
	current_thread->wait_merge = NULL;
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
lwt_id(lwt_t input_thread)
{
	return current_thread->lwt_id;
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

