#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

void __initiate (void) __attribute__((constructor));

/* --------------- Global variable --------------- */

/* used for assigning thread id */
int lwt_counter = 0;
int thread_initiated = 0;

/* three queues, one for thread either waiting or running, one for zombies, one for recycle */
struct list valid_queue;
struct list block_queue;
struct list recycle_queue;
struct list zombie_queue;

/* identify threads */
lwt_t current_thread;
lwt_t old_thread;


/* --------------- internal function declarations --------------- */


inline void __lwt_dispatch(lwt_context *curr, lwt_context *next);
void __lwt_schedule (void);
lwt_t  __create_thread(int with_stack, lwt_fn_t fn, void * data);
lwt_t  __reuse_thread(lwt_fn_t fn, void * data);
void * __lwt_trampoline();
void __initiate(void);



/* --------------- inline function declarations --------------- */

static inline void
list_insert(struct list * link, struct list * new_link)
{
    new_link->prev = link->prev;
    new_link->next = link;
    new_link->prev->next = new_link;
    new_link->next->prev = new_link;
}

/* Inint list */
static inline void
list_init(struct list *list)
{
    list->next = list;
    list->prev = list;
}


/* add a thread to tail of a thread queue */
static inline void
__add_to_tail (lwt_t thread, struct list * thread_queue)
{
    list_insert(thread_queue, (struct list *)(&thread->linked_list));
}

/* add a thread to head of a thread queue */
static inline void
__add_to_head (lwt_t thread, struct list * thread_queue)
{
    list_insert(thread_queue->next, &thread->linked_list);
}

/* remove a thread from a queue */
static inline void
__remove_from_queue(lwt_t thread)
{
    (&thread->linked_list)->prev->next = (&thread->linked_list)->next;
    (&thread->linked_list)->next->prev = (&thread->linked_list)->prev;
}


/* init a struct of lwt */
static inline void
__init_thread(lwt_t created_thread)
{
    created_thread->lwt_id = lwt_counter ++;
    created_thread->status = LWT_INFO_NTHD_RUNNABLE;
    created_thread->merge_to = NULL;
    created_thread->wait_merge = NULL;
    created_thread->last_word = NULL;
}

/* init a stack */
static inline void
__init_stack(lwt_t thread, lwt_fn_t fn, void * data)
{
    thread->context.sp = thread->init_sp;
    thread->context.sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)thread->context.sp) = (uint)data;
    thread->context.sp -= (sizeof(uint));
    *((uint *)thread->context.sp) = (uint)fn;
    thread->context.sp -= (sizeof(uint));
    thread->context.ip = (uint) __lwt_trampoline;
}



/* --------------- Function implementations --------------- */

/* pause one thread, start executing the next one */
inline void
__lwt_dispatch(lwt_context * curr, lwt_context * next)
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
    old_thread = current_thread;
    current_thread = (lwt_t)(valid_queue.next);
    if (current_thread && current_thread != old_thread)
    {
        printd("thread %d start executing from reschedule\n", current_thread->lwt_id);
        __lwt_dispatch(&old_thread->context, &current_thread->context);
        return;
    }
    else
    {
        current_thread = old_thread;
        printd("thread %d cannot find a valid thread to dispatch, keep executing\n",current_thread->lwt_id);
        return;
    }
}

/* create and initialize a thread */
lwt_t
__create_thread(int with_stack, lwt_fn_t fn, void * data)
{
    lwt_t  created_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
    __init_thread(created_thread);
    /* create a stack for the thread */
    if (with_stack)
    {
        /* init stack with die function */
        created_thread->init_sp = (uint) malloc(MAX_STACK_SIZE);
        __init_stack(created_thread, fn, data);
    }
    printd("create thread %d complete\n", created_thread->lwt_id);
    return created_thread;
}

/* reuse a thread from recycle_queue instead of create */
lwt_t
__reuse_thread(lwt_fn_t fn, void * data)
{
    lwt_t reused_thread = (lwt_t)(recycle_queue.next);
    __remove_from_queue(reused_thread);
    __init_thread(reused_thread);
    printd("create thread %d from recycle\n", reused_thread->lwt_id);
    uint _sp = reused_thread->init_sp;
    _sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)_sp) = (uint)data;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)fn;
    _sp -= (sizeof(uint));
    reused_thread->context.sp = _sp;
    reused_thread->context.ip = (uint) __lwt_trampoline;
    printd("create thread %d from recycle\n", reused_thread->lwt_id);
    return reused_thread;
}


/* initialize main thread and the queues when user called create at first time */
void
__initiate()
{
    thread_initiated = 1;
    current_thread = __create_thread(0, (void *)NULL, NULL);
    /* initialize valid_queue */
    list_init(&valid_queue);
    
    /* initialize block_queue */
    list_init(&block_queue);
    
    /* initialize recycle queue */
    list_init(&recycle_queue);
    
    /* initialize zombie_queue */
    list_init(&zombie_queue);
    
    __add_to_tail(current_thread, &valid_queue);
    printd("initialization complete\n");

}


/* create a thread, return its lwt_t pointer */
lwt_t
lwt_create(lwt_fn_t fn, void * data)
{
    lwt_t  next_thread;
    /* decide if re-use from recycle queue */
    next_thread = (recycle_queue.next != recycle_queue.prev) ? __reuse_thread(fn, data) : __create_thread(1, fn, data);
    printd("thread: %d has created thread: %d\n", current_thread->lwt_id,next_thread->lwt_id);
    __add_to_tail(next_thread, &valid_queue);
    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void
lwt_die(void * message)
{
    printd("die function start executing for thread %d.\n",current_thread->lwt_id);
    current_thread->last_word=message;
    /* if someone is waiting to join this one, return and go to recycle queue */
    if (current_thread->merge_to)
    {
        current_thread->merge_to->status = LWT_INFO_NTHD_RUNNABLE;
        current_thread->merge_to->last_word = message;
        __remove_from_queue(current_thread->merge_to);
        __add_to_tail(current_thread->merge_to, &valid_queue);
        
        
        current_thread->merge_to = NULL;
        current_thread->status = LWT_INFO_NTHD_ZOMBIES;
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &recycle_queue);
        printd("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
    }
    /* nobody is currently waiting to join this one, becomes a zombie */
    else
    {
        current_thread->status = LWT_INFO_NTHD_ZOMBIES;
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &zombie_queue);
        printd("removed dead thread %d to zombie queue\n", current_thread->lwt_id);
    }
    
    /* go die, pass flow to another thread */
    __lwt_schedule();
}

/* start a thread, execute its function, get return value and ready to kill the thread */
void *
__lwt_trampoline(lwt_fn_t fn, void * data)
{
    void * return_message = fn(data);
    printd("thread %d ready to die, with last word %d\n", current_thread->lwt_id,(int)return_message);
    lwt_die(return_message);
    return NULL;
}

/* put the thread to run queue end, allow others to execute, if argument has a value, yield to a specific thread */
int
lwt_yield(lwt_t strong_thread)
{
    /* yield to NULL */
    if (!strong_thread)
    {
        printd("thread %d has yielded\n", current_thread->lwt_id);
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &valid_queue);
        __lwt_schedule();
        return 0;
    }
    
    /* yield to itself */
    if (strong_thread == current_thread || strong_thread->status != LWT_INFO_NTHD_RUNNABLE)
    {
        printd("thread %d is yielding to itself or it is not runable\n",current_thread->lwt_id);
        return 0;
    }
    
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &valid_queue);
    __remove_from_queue(strong_thread);
    __add_to_head(strong_thread, &valid_queue);
    __lwt_schedule();
    
    return 0;
}

/* blocked and wait for the argument thread, when argument thread ends, resume execution and return message from the dead thread */
void *
lwt_join(lwt_t thread_to_wait)
{
    
    if(thread_to_wait == NULL || thread_to_wait == current_thread || thread_to_wait->merge_to != NULL)
    {
        printd("error: thread to wait is NULL or itself or nobody waits it\n");
        return NULL;
    }
    
    if(thread_to_wait->status == LWT_INFO_NTHD_ZOMBIES)
    {
        printd("current thread is collecting a zombie thread\n");
        __remove_from_queue(thread_to_wait);
        __add_to_tail(thread_to_wait, &recycle_queue);
        return thread_to_wait->last_word;
    }
    /* update both thread */
    current_thread->wait_merge = thread_to_wait;
    thread_to_wait->merge_to = current_thread;
    printd("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
    current_thread->status = LWT_INFO_NTHD_BLOCKED;
    /* Move to blocked queue */
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &block_queue);
    
    __lwt_schedule();
    printd("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, current_thread->wait_merge->lwt_id, (int)current_thread->last_word);
    current_thread->wait_merge = NULL;
    return current_thread->last_word;
    
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
    int cnt = 0;
    struct list * current;
    
    if (t == LWT_INFO_NTHD_ZOMBIES)
    {
        current = zombie_queue.next;
        while (current != &zombie_queue)
        {
            if (((lwt_t) current)->status == t) cnt ++;
            current = current->next;
        }
        
    }
    else
    {
        current = valid_queue.next;
        while (current != &valid_queue)
        {
            if (((lwt_t) current)->status == t) cnt ++;
            current = current->next;
        }
    }
    return cnt;
    
}

