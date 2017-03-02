#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"
#include "lwt_list.h"
//#include "lwt_dispatch.h"

/* --------------- initialization function --------------- */
void __initiate (void) __attribute__((constructor));


/* --------------- global variable --------------- */

/* used for assigning thread and channel id */
int lwt_counter = 0;
int chan_counter = 0;
int zombie_counter = 0;
int block_counter = 0;
int nrcving = 0;
int nsnding = 0;

/* four queues, one for thread running, one for blocking, one for zombies, one for recycle */
struct list_head run_queue;
//struct list_head block_queue;
//struct list_head zombie_queue;
struct list_head recycle_queue;

/* two channel queues, one for working channel, one for dead channel */
struct list_head chan_working;
struct list_head chan_dead;

/* identify threads */
lwt_t current_thread;
lwt_t old_thread;


/* --------------- internal function declarations --------------- */
void __lwt_schedule (void);
void * __lwt_trampoline(lwt_fn_t, void *);
void __initiate(void);
void __print_a_thread_queue(struct list_head *);
void __print_a_chan_queue(struct list_head *);
int __get_queue_size(struct list_head *);
//int __get_blocked_queue_size(enum block_reason);


/* --------------- inline function definition --------------- */

/* initiate a struct of lwt */
static inline void
__init_thread(lwt_t created_thread)
{
    created_thread->lwt_id = lwt_counter++;
    created_thread->state = LWT_STATUS_RUNNABLE;
    created_thread->merge_to = NULL;
    created_thread->last_word = NULL;
}


/* initiate a channel */
static void inline
__init_chan(lwt_chan_t chan)
{
    chan->receiver = current_thread;
    chan->snd_cnt = 0;
    chan->chan_id = chan_counter++;
    list_head_init(&(chan->sender_queue));
    list_head_append_d(&chan_working, chan);
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
    current_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
    __init_thread(current_thread);

    /* initialize run_queue */
    list_head_init(&run_queue);

    /* initialize block_queue */
//    list_head_init(&block_queue);

    /* initialize recycle queue */
    list_head_init(&recycle_queue);

    /* initialize zombie_queue */
//    list_head_init(&zombie_queue);

    /* initialize working channel queue */
    list_head_init(&chan_working);

    /* initialize dead channel queue */
    list_head_init(&chan_dead);

    list_head_append_d(&run_queue, current_thread);
    printd("initialization complete\n");

}

/* create a thread, return its lwt_t pointer */
lwt_t
lwt_create(lwt_fn_t fn, void * data)
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

    printd("thread: %d has created thread: %d\n", current_thread->lwt_id, next_thread->lwt_id);

    list_head_add_d(&run_queue, next_thread);

    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void
lwt_die(void * message)
{
    printd("die function start executing for thread %d.\n", current_thread->lwt_id);

    current_thread->last_word = message;

    /* if someone is waiting to join this one, return and go to recycle queue */
    if (unlikely((long int)current_thread->merge_to))
    {
        current_thread->merge_to->state = LWT_STATUS_RUNNABLE;
        current_thread->merge_to->last_word = message;
        
        block_counter--;

        list_rem_d(current_thread->merge_to);
        list_head_add_d(&run_queue, current_thread->merge_to);

        current_thread->state = LWT_STATUS_ZOMBIES;
        
        list_rem_d(current_thread);
        list_head_add_d(&recycle_queue, current_thread);

        printd("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
    }
    /* nobody is currently waiting to join this one, becomes a zombie */
    else
    {
        current_thread->state = LWT_STATUS_ZOMBIES;
        list_rem_d(current_thread);
//        list_head_add_d(&zombie_queue, current_thread);
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
    if (yield_to == current_thread || (yield_to && yield_to->state != LWT_STATUS_RUNNABLE))
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
    list_head_add_d(&run_queue, current_thread);

    __lwt_schedule();

    return 0;
}

/* blocked and wait for the argument thread to die, get last word of that thread, resume execution */
void *
lwt_join(lwt_t thread_to_wait)
{

    if(!thread_to_wait || thread_to_wait == current_thread || thread_to_wait->merge_to)
    {
        printd("error: thread to wait is NULL or itself or nobody waits it\n");
        return NULL;
    }
    if(unlikely(thread_to_wait->state == LWT_STATUS_ZOMBIES))
    {
        printd("current thread is collecting a zombie thread\n");
        list_rem_d(thread_to_wait);
        zombie_counter--;
        list_head_add_d(&recycle_queue, thread_to_wait);

        return thread_to_wait->last_word;
    }
    /* update both thread */
    thread_to_wait->merge_to = current_thread;

    printd("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);

    current_thread->state = LWT_STATUS_BLOCKED;
    current_thread->block_for = BLOCKED_JOIN;

    /* Move to blocked queue */
    list_rem_d(current_thread);
//    list_head_add_d(&block_queue, current_thread);
    block_counter++;
    __lwt_schedule();

    printd("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, thread_to_wait->lwt_id, (int)current_thread->last_word);

    return current_thread->last_word;
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

/* --------------- Thread communication function implementation, channelling --------------- */


/* create a thread with initial channel, receiver become created thread, creator thread become sender */
lwt_t
lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t chan)
{
    lwt_t created_thread = lwt_create((void *)fn, (void *)chan);
    chan->snd_cnt += 1;
    printd("thread %d has created thread %d with channel %d.\n", current_thread->lwt_id, created_thread->lwt_id,chan->chan_id);
    return created_thread;
}
/* create a channel, current_thread is the receiver */
lwt_chan_t
lwt_chan(int size)
{
    lwt_chan_t chan;
    if (!list_head_empty(&chan_dead))
    {
        /* not empty */
        chan = list_head_first_d(&chan_dead, struct _lwt_channel);
        list_rem_d(chan);
        printd("create one channel from dead channel pool.\n");
    }
    else
    {
        chan = (lwt_chan_t)malloc(sizeof(struct _lwt_channel));
    }
    __init_chan(chan);
    printd("thread %d has created channel %d.\n", current_thread->lwt_id, chan->chan_id);
    return chan;
}

/* dereference a channel, announce this channel is no longer used by the caller thread */
void
lwt_chan_deref (lwt_chan_t chan)
{
    if (unlikely(chan->receiver == current_thread))
    {
        chan->receiver = NULL;
        printd("thread %d is nolonger receiver of channel %d.\n", current_thread->lwt_id, chan->chan_id);
    }
    else chan->snd_cnt--;
    printd("thread %d has de-ref channel %d, sender left: %d.\n", current_thread->lwt_id, chan->chan_id, chan->snd_cnt);
    if (chan->snd_cnt == 0 && chan->receiver == NULL) {
        printd("channel %d has been freed from memory.\n", chan->chan_id);
        list_rem_d(chan);
        list_head_add_d(&chan_dead, chan);
    }
}

/* send data through a channel, block sender until receiver received the data */
int
lwt_snd(lwt_chan_t chan, void * data)
{
    if (unlikely(chan->receiver == NULL))
    {
        printd("thread %d has send data to channel %d, but no receiver.\n", current_thread->lwt_id, chan->chan_id);
        return -1;
    }
    current_thread->message_data = data;
    printd("current_thread: %d, channel: %d\n", current_thread->lwt_id, chan->chan_id);
    list_rem_d(current_thread);
    list_head_add_d(&(chan->sender_queue), current_thread);
    nsnding++;
    block_counter++;
    current_thread->state = LWT_STATUS_BLOCKED;
    current_thread->block_for = BLOCKED_SENDING;
    printd("thread %d is waiting for channel %d's receiver thread %d.\n", current_thread->lwt_id, chan->chan_id, chan->receiver->lwt_id);
    if (chan->receiver->state == LWT_STATUS_BLOCKED && chan->receiver->block_for == BLOCKED_RECEIVING)
    {
        nrcving--;
        block_counter--;
        chan->receiver->state = LWT_STATUS_RUNNABLE;
        list_rem_d(chan->receiver);
        list_head_append_d(&run_queue, chan->receiver);
        printd("thread %d wake up and ready to receive data from channel %d.\n", chan->receiver->lwt_id, chan->chan_id);
    }
    __lwt_schedule();
    return 0;
}

/* receive data from a channel, if no sender queueing, block the thread and wait till data sent by the sender */
void *
lwt_rcv(lwt_chan_t chan)
{
    if (chan->snd_cnt == 0)
    {
        printd("thread %d is receiving from channel %d with no sender.\n", current_thread->lwt_id, chan->chan_id);
        return NULL;
    }
    void * result;

    if (list_head_empty(&(chan->sender_queue)))
    {
        printd("thread %d is receiving channel %d, no sender yet.\n", current_thread->lwt_id, chan->chan_id);
        current_thread->state = LWT_STATUS_BLOCKED;
        current_thread->block_for = BLOCKED_RECEIVING;
        list_rem_d(current_thread);
//        list_head_add_d(&block_queue, current_thread);
        block_counter++;
        nrcving++;
        __lwt_schedule();
    }
    printd("thread %d resumed to receive data from channel %d.\n", current_thread->lwt_id, chan->chan_id);

    lwt_t sender = list_head_first_d(&(chan->sender_queue), struct _lwt_t);
    sender->state = LWT_STATUS_RUNNABLE;
    nsnding--;
    block_counter--;
    result = sender->message_data;

    list_rem_d(sender);
    list_head_append_d(&run_queue, sender);
    return result;
}

/* send a channel through a channel */
int lwt_snd_chan(lwt_chan_t through, lwt_chan_t sending)
{
    int return_value = lwt_snd(through, (void *) sending);
    return return_value;
}

/* receive a channel from a channel, the receiver can access the sending channel, so it becomes a sender of it */
lwt_chan_t lwt_rcv_chan(lwt_chan_t chan)
{
    lwt_chan_t rec = lwt_rcv(chan);
    if (rec) {
        rec->snd_cnt++;
    }
    return rec;
}

/* --------------- internal function for user level debugging --------------- */

/* get a queue size */
int
__get_queue_size(struct list_head * input_list)
{
    int cnt = 0;
    struct list * curr = (input_list->l).n;
    while (curr != &(input_list->l))
    {
        cnt++;
        curr = curr->n;
    }
    return cnt;
}

/* get the size of blocked thread with a particular block reason */
//int
//__get_blocked_queue_size(enum block_reason block_for)
//{
//    int cnt = 0;
//    struct list * curr = block_queue.l.n;
//    while (curr != &(block_queue.l))
//    {
//        if((container(curr, struct _lwt_t, list_node))->block_for == block_for) cnt++;
//        curr = curr->n;
//   }
//    return cnt;
//}

/* print the content of a thread queue */
void
__print_a_thread_queue(struct list_head * list_to_print)
{
    struct list * curr = (list_to_print->l).n;
    while (curr != &(list_to_print->l))
    {
        printd("thread %d.\n", (container(curr, struct _lwt_t, list_node))->lwt_id);
        curr = curr->n;
    }
}

/* print the content of a channel queue */
void
__print_a_chan_queue(struct list_head * list_to_print)
{
    struct list * curr = (list_to_print->l).n;
    while (curr != &(list_to_print->l))
    {
        printd("channel %d.\n", (container(curr, struct _lwt_channel, list_node))->chan_id);
        curr = curr->n;
    }
}

/* --------------- User level debugging functions implementation --------------- */

/* return the informatin of current thread status */
int
lwt_info(enum lwt_info_t t)
{
    switch (t) {
        case LWT_INFO_NTHD_RUNNABLE:
            return __get_queue_size(&run_queue);
        case LWT_INFO_NTHD_BLOCKED:
            return block_counter;
        case LWT_INFO_NTHD_ZOMBIES:
            return zombie_counter;
        case LWT_INFO_NTHD_RECYCLE:
            return __get_queue_size(&recycle_queue);
        case LWT_INFO_NCHAN:
            return __get_queue_size(&chan_working);
        case LWT_INFO_DCHAN:
            return __get_queue_size(&chan_dead);
        case LWT_INFO_NSNDING:
            return nsnding;
        case LWT_INFO_NRCVING:
            return nrcving;
        default:
            printd("cannot identify printing instructions\n");
            return -1;
    }
}

/* print the content of a queue */
void
print_queue_content(enum lwt_info_t input)
{
    switch (input)
    {
        case LWT_INFO_NTHD_RUNNABLE:
            printd("runnable queue showed as below: \n");
            __print_a_thread_queue(&run_queue);
            break;
        case LWT_INFO_NTHD_RECYCLE:
            printd("recycle queue showed as below: \n");
            __print_a_thread_queue(&recycle_queue);
            break;
        case LWT_INFO_NCHAN:
            printd("working channel showed as below: \n");
            __print_a_chan_queue(&chan_working);
            break;
        case LWT_INFO_DCHAN:
            printd("dead channel showed as below: \n");
            __print_a_chan_queue(&chan_dead);
            break;
        default:
            printd("cannot identify printing instructions\n");
            break;
    }
}
