#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"
#include "lwt_dispatch.h"

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
int __move_thread_to_head(lwt_t *);
int __move_thread_to_tail(lwt_t *);
void __remove_from_list(lwt_t *);

static void __initiate(void);
int __move_thread_to_pool (lwt_t *);

/* Function implemetion */

void __remove_from_list(lwt_t * p_thread)
{
    if (!p_thread) return;
    
    p_thread->status = LWT_INFO_NTHD_ZOMBIES;
    
    /* Remove from run queue */
    if (p_thread == thread_queue.head)
    {
        p_thread->next->prev = NULL;
        thread_queue.head = p_thread->next;
    }
    else if (p_thread == thread_queue.tail)
    {
        p_thread->prev->next = NULL;
        thread_queue.tail = p_thread->prev;
    }
    else
    {
        p_thread->prev->next = p_thread->next;
        p_thread->next->prev = p_thread->prev;
    }
    
    thread_queue.node_count --;
}

int __move_thread_to_pool (lwt_t * p_thread)
{
    __remove_from_list(p_thread);
    
    /* Refresh */
    
    /* Move to pool */
    return __add_thread_to_list_tail(p_thread, &zombie_pool);
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
    lwt_t * next_thread = (lwt_t *) malloc (sizeof(lwt_t));
    
    /* Return lwt_die */
    uint _sp = (uint) malloc(MAX_STACK_SIZE);
    _sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)_sp) = (uint)NULL;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)lwt_die;
    
    
    
    /* Construct new thread */
    next_thread->lwt_id = lwt_counter ++;
    next_thread->status = LWT_INFO_NTHD_RUNNABLE;
    next_thread->context.sp = _sp;
    next_thread->context.ip = (uint) fn;
    
    
    __add_thread_to_list_tail(next_thread, &thread_queue);
    
    __lwt_dispatch(&current_thread->context, &schedule_context);
    
    return next_thread;
}

int
lwt_yield(lwt_t * lwt)
{
    __remove_from_list(current_thread);
    
    if (lwt)
    {
        printf("goto specified thread \n");
        __add_thread_to_list_head(current_thread, &thread_queue);
    }
    else
    {
        printf("resched \n");
        __add_thread_to_list_tail(current_thread, &thread_queue);
    }
    
    __lwt_dispatch(&current_thread->context, &schedule_context);
    return 0;
}

void
lwt_die(void * p_thread)
{
    if (!p_thread)
    {
        /* lwt_die(NULL) */
        current_thread->status = LWT_INFO_NTHD_ZOMBIES;
        
    }
    else
    {
        /* TODO kill specialfic thread */
    }
    
    //thread_queue.node_count --;
    
    __lwt_schedule();
}
