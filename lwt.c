#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"
#include "lwt_list.h"

/* --------------- initialization function --------------- */
void __initiate (void) __attribute__((constructor));

/* --------------- global variable --------------- */

extern int block_counter;
extern int lwt_counter;
extern int zombie_counter;

/* two channel queues, one for working channel, one for dead channel */
extern struct list_head chan_working;
extern struct list_head chan_dead;

/* four queues, one for thread running, one for blocking, one for zombies, one for recycle */
struct list_head run_queue;
struct list_head recycle_queue;


/* identify threads */
lwt_t current_thread;
lwt_t old_thread;



/* --------------- internal function declarations --------------- */
void __lwt_schedule (void);
void * __lwt_trampoline(lwt_fn_t, void *);
void __initiate(void);
void __print_a_thread_queue(struct list_head *);


/* --------------- inline function definition --------------- */

/* initiate a struct of lwt */
static inline void
__init_thread(lwt_t created_thread)
{
    created_thread->lwt_id = lwt_counter++;
    created_thread->state = LWT_RUNNING;
    created_thread->parent = NULL;
    created_thread->message_data = NULL;
    created_thread->chl = lwt_chan(0);
    /* NOTE: here snd_cnt is manually changed */
    created_thread->chl->snd_cnt += 1;
    created_thread->nojoin = 0;
}




/* --------------- Major thread-function implementations --------------- */

/* pause one thread, start executing the next one */
static inline void
__lwt_dispatch(struct _lwt_context * curr, struct _lwt_context * next)
{
    __asm__ __volatile__
    (
     //        "push %%ebx;"
     //        "push %%edi;"
     //        "push %%esi;"
     //        "push %%ebp;"
     //        "push %%eax;"
     "pushal;"
     "movl %%esp,%0;"
     "movl $retDispatch%=,%1;"
     "movl %2,%%esp;"
     "jmp *%3;"
     "retDispatch%=:;"
     "popal;"
     //        "pop %%eax;"
     //        "pop %%ebp;"
     //        "pop %%esi;"
     //        "pop %%edi;"
     //        "pop %%ebx;"
     : "=m" (curr->sp),"=m" (curr->ip)
     : "m" (next->sp),"m" (next->ip)
     : "cc", "memory"
     //        : "ebx", "edi", "esi", "ebp", "eax", "memory"
     
     );
}

/* find one runnable thread and execute it */
inline void
__lwt_schedule ()
{
    old_thread = current_thread;
    current_thread = list_head_first_d(&run_queue, struct _lwt_t);
    printd("thread %d start executing from reschedule\n", current_thread->lwt_id);
    current_thread->state = LWT_RUNNING;
    __lwt_dispatch(&(old_thread->context), &(current_thread->context));
}


/* initialize the library */
void
__initiate()
{
    
    /* initialize run_queue */
    list_head_init(&run_queue);
    
    /* initialize recycle queue */
    list_head_init(&recycle_queue);
    
    
    /* initialize working channel queue */
    list_head_init(&chan_working);
    
    /* initialize dead channel queue */
    list_head_init(&chan_dead);
    
    
    current_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
    __init_thread(current_thread);
    current_thread->state = LWT_RUNNING;
    
    list_head_append_d(&run_queue, current_thread);
    printd("initialization complete\n");
    
}

/* create a thread, return its lwt_t pointer */
lwt_t
lwt_create(lwt_fn_t fn, void * data, lwt_flags_t flags)
{
    lwt_t next_thread;
    uint _sp;
    
    if (unlikely(!list_head_empty(&recycle_queue))) {
        /* recycle queue is not empty */
        next_thread = list_head_first_d(&recycle_queue, struct _lwt_t);
        list_rem_d(next_thread);
        _sp = next_thread->init_sp;
    }
    else
    {
        /* Create new thread */
        next_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
        _sp = (uint) malloc(MAX_STACK_SIZE);
        _sp += MAX_STACK_SIZE;
        next_thread->init_sp = _sp;
    }
    
    /* Init other data */
    __init_thread(next_thread);
    
    
    /* Init funciton info */
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)data;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)fn;
    _sp -= (sizeof(uint));
    
    next_thread->context.sp = _sp;
    next_thread->context.ip = (uint) __lwt_trampoline;
    
    if (flags & LWT_NOJOIN) {
        next_thread->nojoin = 1;
    }
    
    printd("thread: %d has created thread: %d\n", current_thread->lwt_id, next_thread->lwt_id);
    
    list_head_add_d(&run_queue, next_thread);
    
    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void
lwt_die(void * message)
{
    printd("die function start executing for thread %d.\n", current_thread->lwt_id);
    
    current_thread->message_data = message;
    
    
    if (unlikely((long int)current_thread->parent))
    {
        lwt_snd(current_thread->chl, message);
        
        current_thread->state = LWT_ZOMBIES;
        
        list_rem_d(current_thread);
        list_head_add_d(&recycle_queue, current_thread);
        
        printd("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
        
    }
    else
    {
        current_thread->state = LWT_ZOMBIES;
        list_rem_d(current_thread);
        zombie_counter++;
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
    printd("thread %d ready to die, with last word %d\n", current_thread->lwt_id, (int)return_message);
    lwt_die(return_message);
    return NULL;
}

/* put the thread to run queue end, allow others to execute, if argument has a value, yield to a specific thread */
int
lwt_yield(lwt_t yield_to)
{
    /* yield to itself */
    if (yield_to == current_thread || (yield_to && yield_to->state != LWT_RUNNABLE && yield_to->state != LWT_RUNNING))
    {
        printd("thread %d is yielding to itself or it is not runable\n",current_thread->lwt_id);
        return 0;
    }
    /* yield to NULL */
    if (likely((long int)yield_to))
    {
        list_rem_d(yield_to);
        list_head_append_d(&run_queue, yield_to);
    }
    
    list_rem_d(current_thread);
    if (current_thread->state == LWT_RUNNABLE || current_thread->state == LWT_RUNNING)
        list_head_add_d(&run_queue, current_thread);
    
    __lwt_schedule();
    
    return 0;
}

/* blocked and wait for the argument thread to die, get last word of that thread, resume execution */
void *
lwt_join(lwt_t thread_to_wait)
{
    
    if(!thread_to_wait || thread_to_wait == current_thread || thread_to_wait->parent || thread_to_wait->nojoin)
    {
        printd("error: thread to wait is NULL or itself or nobody waits it\n");
        return NULL;
    }
    if(unlikely(thread_to_wait->state == LWT_ZOMBIES))
    {
        printd("current thread is collecting a zombie thread\n");
        list_rem_d(thread_to_wait);
        zombie_counter--;
        list_head_add_d(&recycle_queue, thread_to_wait);
        
        //return thread_to_wait->message_data;
        return NULL;
    }
    
    /* update oneside thread */
    thread_to_wait->parent = current_thread;
    return lwt_rcv(thread_to_wait->chl);
    
    
}

/* return current thread */
lwt_t
lwt_current()
{
    return current_thread;
}

/* return the id of a thread */
int
lwt_id(lwt_t input_thread)
{
    return current_thread->lwt_id;
}


