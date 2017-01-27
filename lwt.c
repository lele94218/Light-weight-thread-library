#include <stdio.h> #include <stdlib.h>

#include "lwt.h"
#include "lwt_dispatch.h"
#include <stdlib.h>

/* Global variable */
int lwt_counter = 0;
int thread_initiated = 0;

lwt_context schedule_context;
/* Run queue */
linked_list thread_queue;
lwt_t * current_thread;


/* Zombie pool */
linked_list zombie_pool;

/* Extern function declaration */
void __lwt_schedule (void);
lwt_t *  __get_next_thread ();
int __add_thread_to_list_tail (lwt_t *, linked_list *);
int __add_thread_to_list_head (lwt_t *, linked_list *);
void __remove_from_list(lwt_t *, linked_list *);
void * __lwt_trampoline();

static void __initiate(void);
int __move_thread_to_pool (lwt_t *, linked_list *, linked_list *);

/* Function implemetion */

void __remove_from_list(lwt_t * p_thread, linked_list * list)
{
    if (!p_thread) return;
    
    
    /* Remove from run queue */
    if (p_thread == list->head)
    {
        p_thread->next->prev = NULL;
        list->head = p_thread->next;
    }
    else if (p_thread == thread_queue.tail)
    {
        p_thread->prev->next = NULL;
        list->tail = p_thread->prev;
    }
    else
    {
        p_thread->prev->next = p_thread->next;
        p_thread->next->prev = p_thread->prev;
    }
    
    thread_queue.node_count --;
}

int __move_thread_to_pool (lwt_t * p_thread, linked_list * run_list, linked_list * zombie_list)
{
    __remove_from_list(p_thread, run_list);
    
    /* Refresh */
    
    /* Move to pool */
    return __add_thread_to_list_tail(p_thread, zombie_list);
}

int
__add_thread_to_list_tail (lwt_t * thread, linked_list * list)
{
    
    if (!list->node_count)
    {
        list->head = thread;
        list->tail = thread;
    }
    else
    {
        list->tail->next = thread;
        thread->prev = list->tail;
        list->tail = thread;
    }
    
    ++ list->node_count;
    return list->node_count - 1;
}

int
__add_thread_to_list_head (lwt_t * thread, linked_list * list)
{
    
    thread->prev= NULL;
    if (!list->node_count)
    {
        list->head = thread;
        list->tail = thread;
    }
    else
    {
        list->head->prev = thread;
        thread->next=list->head;
        list->head= thread;
    }
    ++ list->node_count;
    return list->node_count - 1;
}

lwt_t *
__get_next_thread ()
{
    lwt_t * curr = thread_queue.head;
    // TODO scheduling
    while (curr)
    {
        if (curr->status == LWT_INFO_NTHD_RUNNABLE){
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

void
__lwt_schedule ()
{
    while (1)
    {
        current_thread = __get_next_thread();
        if (current_thread)
            __lwt_dispatch(&schedule_context, &current_thread->context);
    }
}

static void
__initiate()
{
    thread_initiated = 1;
    
    /* Add main thread to TCB */
    current_thread = (lwt_t * ) malloc (sizeof(lwt_t));
    current_thread->lwt_id = lwt_counter ++;
    current_thread->status = LWT_INFO_NTHD_RUNNABLE;
    
    /* Add to TCB */
    __add_thread_to_list_tail(current_thread, &thread_queue);
    
    /* Initiate schedule_context */
    uint _sp = (uint) malloc(MAX_STACK_SIZE);
    _sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)_sp) = (uint)__lwt_schedule;
    schedule_context.sp = _sp;
    schedule_context.ip = (uint) __lwt_schedule;
    
}


lwt_t *
lwt_create(lwt_fn_t fn, void * data)
{
    if(!thread_initiated) __initiate();
//    lwt_t * next_thread = (lwt_t *) malloc (sizeof(lwt_t));
    lwt_t * next_thread=zombie_pool.node_count? zombie_pool.head:(lwt_t *) malloc (sizeof(lwt_t));
    
    /* Return lwt_die */
//    uint _sp = (uint) malloc(MAX_STACK_SIZE);
//    _sp += (MAX_STACK_SIZE - sizeof(uint));
//    *((uint *)_sp) = (uint)NULL;
//    _sp -= (sizeof(uint));
//    *((uint *)_sp) = (uint)lwt_die;
    
    /* Construct new thread */
    next_thread->lwt_id = lwt_counter ++;
    next_thread->status = LWT_INFO_NTHD_RUNNABLE;
    next_thread->next=NULL;
    next_thread->prev=NULL;
    next_thread->unlock=NULL;
    next_thread->waiting_for=NULL;
    next_thread->last_word=NULL;
    
    uint _sp = (uint) malloc(MAX_STACK_SIZE);
    _sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)_sp) = (uint)data;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)__lwt_trampoline;
    next_thread->context.sp = _sp;
    next_thread->context.ip = (uint) fn;
    
    __add_thread_to_list_tail(next_thread, &thread_queue);
    
    __lwt_dispatch(&current_thread->context, &schedule_context);
    
    return next_thread;
}

int
lwt_yield(lwt_t * lwt)
{
    __remove_from_list(current_thread, &thread_queue);
    __add_thread_to_list_tail(current_thread, &thread_queue);
    
    
    
    if (lwt)
    {
        printf("goto specified thread \n");
        __remove_from_list(lwt, &thread_queue);
        __add_thread_to_list_head(lwt, &thread_queue);
    }
    else
    {
        printf("resched \n");
    }
    
    __lwt_dispatch(&current_thread->context, &schedule_context);
//    __lwt_schedule();
    return 0;
}



//lwt_die(void * p_thread)
//{
//    if (!p_thread)
//    {
//        /* lwt_die(NULL) */
//        current_thread->status = LWT_INFO_NTHD_ZOMBIES;

//    }
//    else
//    {
        /* TODO kill specialfic thread */
//    }
    
    //thread_queue.node_count --;
    
 //   __lwt_schedule();
//}

void
lwt_die(void * message)
{
    printf("die function received %d as argument\n",(int)message);
    current_thread->last_word=message;
    /* unlock the threads that are waiting */
    lwt_t * tmp=current_thread;
    lwt_t * prevtmp;
    while(tmp->unlock)
    {
        tmp->unlock->status=LWT_INFO_NTHD_RUNNABLE;
        printf("thread %d about to die and join thread %d\n", current_thread->lwt_id, tmp->unlock->lwt_id);
        prevtmp=tmp;
        tmp=tmp->unlock;
        prevtmp->unlock=NULL;
    }
    
    /* go die */
    current_thread->status=LWT_INFO_NTHD_ZOMBIES;
    __remove_from_list(current_thread, &thread_queue);
    __add_thread_to_list_tail(current_thread, &zombie_pool);
    printf("removed dead thread %d from valid queue\n", current_thread->lwt_id);
    __lwt_schedule();
}

void *
lwt_join(lwt_t * thread_to_wait)
{
    current_thread->waiting_for=thread_to_wait;
    if(thread_to_wait==NULL)
    {
        printf("error: current thread is waiting for a thread does not exists");
    }
    else if(thread_to_wait->status==LWT_INFO_NTHD_ZOMBIES)
    {
        printf("error: current thread is waiting for a dead thread");
    }
    lwt_t * curr=thread_to_wait;
    while (curr->unlock)
    {
        curr=curr->unlock;
    }
    curr->unlock=current_thread;
    
    printf("thread %d blocked, waiting for thread %d\n", current_thread->lwt_id, thread_to_wait->lwt_id);
    current_thread->status=LWT_INFO_NTHD_BLOCKED;
//    __remove_from_list(current_thread, &thread_queue);
//    __add_thread_to_list_tail(current_thread, &thread_queue);
//    __lwt_schedule();
    __lwt_dispatch(&current_thread->context, &schedule_context);
    printf("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, current_thread->waiting_for->lwt_id,(int)current_thread->waiting_for->last_word);
    void * message=current_thread->waiting_for->last_word;
    current_thread->waiting_for=NULL;
    return message;
}

void * __lwt_trampoline()
{
    void * return_message;
    __asm__ __volatile__("movl %%eax, %0"
                         :"=b" (return_message)
                         :
                         :
                         );
    printf("trampoline captured thread %d's function return value %d\n", current_thread->lwt_id,(int)return_message);
    lwt_die(return_message);
}
