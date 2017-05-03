#include "lwt.h"
#include "umalloc.h"

struct _kthd_info kthds[32];
thdid_t current_kthd=0;

/* --------------- initialization function --------------- */
// void __initiate (void) __attribute__((constructor));

// /* four queues, one for thread running, one for blocking, one for zombies, one for recycle */
// struct list_head run_queue;
// struct list_head recycle_queue;

/* --------------- internal function declarations --------------- */
void __lwt_schedule(void);
void *__lwt_trampoline(lwt_fn_t, void *);
void __print_a_thread_queue(struct list_head *);
void init_kthd(struct _kthd_info *kthd);

/* --------------- inline function definition --------------- */

/* initiate a struct of lwt */
static inline void
__init_thread(lwt_t created_thread,thdid_t k_id)
{
    created_thread->lwt_id = kthds[k_id].lwt_counter++;
    created_thread->state = LWT_RUNNING;
    created_thread->parent = NULL;
    created_thread->message_data = NULL;
    created_thread->chl = lwt_chan(0);
    /* NOTE: here snd_cnt is manually changed */
    created_thread->chl->snd_cnt += 1;
    created_thread->nojoin = 0;
    created_thread->kthd_index = k_id;
}

/* --------------- Major thread-function implementations --------------- */

/* pause one thread, start executing the next one */
static inline void
__lwt_dispatch(struct _lwt_context *curr, struct _lwt_context *next)
{
    __asm__ __volatile__(
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
        : "=m"(curr->sp), "=m"(curr->ip)
        : "m"(next->sp), "m"(next->ip)
        : "cc", "memory"
        //        : "ebx", "edi", "esi", "ebp", "eax", "memory"

        );
}

/* find one runnable thread and execute it */
inline void
__lwt_schedule()
{
    lwt_t old_thread = lwt_current();
    lwt_t new_thread = list_head_first_d(current_run_queue(), struct _lwt_t);
    if (!new_thread) new_thread = kthds[current_kthd].main_thread;
    printd("thread %d start executing from reschedule\n", new_thread->lwt_id);
    new_thread->state = LWT_RUNNING;
    kthds[current_kthd].current_thread = new_thread;
    __lwt_dispatch(&(old_thread->context), &(new_thread->context));
}

/* initialize the library */
void __initiate(thdid_t kthd_id)
{
    init_kthd(&(kthds[kthd_id]));
    kthds[kthd_id].current_thread = (lwt_t)umalloc(sizeof(struct _lwt_t));
    __init_thread(kthds[kthd_id].current_thread, kthd_id);
    kthds[kthd_id].current_thread->state = LWT_RUNNING;
    //list_head_append_d(&(kthds[kthd_id].run_queue), kthds[kthd_id].current_thread);
    kthds[kthd_id].main_thread = kthds[kthd_id].current_thread;
    list_head_append_d(&(kthds[kthd_id].run_queue), kthds[kthd_id].current_thread);
    printc("initialization complete\n");
}

void init_kthd(struct _kthd_info *kthd)
{
    kthd->chan_counter = 0;
    kthd->lwt_counter = 0;
    kthd->block_counter = 0;
    kthd->zombie_counter = 0;
    kthd->nrcving = 0;
    kthd->nsnding = 0;
    list_head_init(&kthd->run_queue);
    list_head_init(&kthd->recycle_queue);
}

/* create a thread, return its lwt_t pointer */
lwt_t lwt_create(lwt_fn_t fn, void *data, lwt_flags_t flags)
{
    lwt_t next_thread;
    uint _sp;
    if (unlikely(!list_head_empty(current_recycle_queue())))
    {
        /* recycle queue is not empty */
        next_thread = list_head_first_d(current_recycle_queue(), struct _lwt_t);
        list_rem_d(next_thread);
        _sp = next_thread->init_sp;
    }
    else
    {
        /* Create new thread */
        next_thread = (lwt_t)umalloc(sizeof(struct _lwt_t));
        _sp = (uint)umalloc(MAX_STACK_SIZE);
        _sp += MAX_STACK_SIZE;
        next_thread->init_sp = _sp;
    }
    /* Init other data */
    __init_thread(next_thread, current_kthd);
    next_thread->parent = lwt_current();

    /* Init funciton info */
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)data;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)fn;
    _sp -= (sizeof(uint));

    next_thread->context.sp = _sp;
    next_thread->context.ip = (uint)__lwt_trampoline;

    if (flags & LWT_NOJOIN)
    {
        next_thread->nojoin = 1;
    }
    printd("thread: %d has created thread: %d\n", lwt_current()->lwt_id, next_thread->lwt_id);

    list_head_add_d(current_run_queue(), next_thread);
    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void lwt_die(void *message)
{
    lwt_t current_thread = lwt_current();

    printd("die function start executing for thread %d.\n", current_thread->lwt_id);
    kthds[current_kthd].zombie_counter++;
    current_thread->message_data = message;
    lwt_snd(current_thread->chl, message);
    current_thread->state = LWT_ZOMBIES;
    kthds[current_kthd].zombie_counter--;
    list_rem_d(current_thread);
    list_head_add_d(current_recycle_queue(), current_thread);
    printd("removed dead thread %d to zombie queue\n", current_thread->lwt_id);
    /* Below is the old code, assuming any thread can collect others, not adapted to composite yet
    if (unlikely((long int)current_thread->parent))
    {
        lwt_snd(current_thread->chl, message);
        
        current_thread->state = LWT_ZOMBIES;
        zombie_counter++;
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
    }*/
    /* go die, pass flow to another thread */
    __lwt_schedule();
}

/* start a thread, execute its function, get return value and ready to kill the thread */
void *
__lwt_trampoline(lwt_fn_t fn, void *data)
{
    void *return_message = fn(data);
    printd("thread %d ready to die, with last word %d\n", lwt_current()->lwt_id, (int)return_message);
    lwt_die(return_message);
    return NULL;
}

/* put the thread to run queue end, allow others to execute, if argument has a value, yield to a specific thread */
int lwt_yield(lwt_t yield_to)
{
    lwt_t current_thread = lwt_current();
    printc("current thread is: %d!\n",current_thread->lwt_id);
    /* yield to itself */
    if (yield_to == current_thread || (yield_to && yield_to->state != LWT_RUNNABLE && yield_to->state != LWT_RUNNING))
    {
        printd("thread %d is yielding to itself or it is not runable\n", current_thread->lwt_id);
        return 0;
    }
    /* yield to some value */
    if (likely((long int)yield_to))
    {
        list_rem_d(yield_to);
        list_head_append_d(current_run_queue(), yield_to);
    }
    /* yield to NULL */
    else
    {    
        printc("yield NULL \n");
        if (current_thread->state == LWT_RUNNABLE || current_thread->state == LWT_RUNNING)
        {
            list_rem_d(current_thread);
            list_head_add_d(current_run_queue(), current_thread);
        }
    }
    printc("begin to schedule \n");
    __lwt_schedule();

    return 0;
}

/* blocked and wait for the argument thread to die, get last word of that thread, resume execution */
void *
lwt_join(lwt_t thread_to_wait)
{
    if (lwt_current() != thread_to_wait->parent || thread_to_wait->nojoin)
    {
        printd("error: invalid thread to wait!\n");
        return NULL;
    }
    printd("thread %d starts collect last word of child thread %d.\n", lwt_current()->lwt_id, thread_to_wait->lwt_id);
    void *data_received = lwt_rcv(thread_to_wait->chl);
    lwt_yield(thread_to_wait);
    /* below code are assuming any thread can join another thread
    if(unlikely(thread_to_wait->state == LWT_ZOMBIES))
    {
        printd("current thread is collecting a zombie thread\n");
        list_rem_d(thread_to_wait);
        list_head_add_d(&recycle_queue, thread_to_wait);
        
        return thread_to_wait->message_data;
    }*/
    return data_received;
}

/* return current thread */
lwt_t lwt_current()
{
    return kthds[current_kthd].current_thread;
}

struct list_head *
current_run_queue()
{
    return &(kthds[current_kthd].run_queue);
}

struct list_head *
current_recycle_queue()
{
    return &(kthds[current_kthd].recycle_queue);
}

/* return the id of a thread */
int lwt_id(lwt_t input_thread)
{
    return input_thread->lwt_id;
}
