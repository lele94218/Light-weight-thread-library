#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

/* initialization function */
void __initiate (void) __attribute__((constructor));


/* --------------- Global variable --------------- */

/* used for assigning thread id */
int lwt_counter = 0;
int chan_counter = 0;
/* offset from the linked list member to its parent struct */
const int offset_thread = (int)(&(((lwt_t)0)->linked_list));
const int offset_sender = (int)(&(((lwt_t)0)->sender_queue));
const int offset_chan = (int)(&(((lwt_chan_t)0)->chan_queue));

/* four queues, one for thread running, one for blocking, one for zombies, one for recycle */
struct list run_queue;
struct list block_queue;
struct list zombie_queue;
struct list recycle_queue;
/* two channel queues, one for working channel, one for dead channel */
struct list chan_working;
struct list chan_dead;

/* identify threads */
lwt_t current_thread;
lwt_t old_thread;


/* --------------- internal function declarations --------------- */
void __lwt_schedule (void);
void * __lwt_trampoline(lwt_fn_t fn, void * data);
void __initiate(void);
void __print_a_thread_queue(struct list *);
void __print_a_chan_queue(struct list *);
int __get_queue_size(struct list * input_list);
int __get_blocked_queue_size(enum block_reason block_for);


/* --------------- inline function definition --------------- */

/* below two functions are universal list operation function */
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

/* below functions are customized linked list operation for a thread queue */
static inline void
__add_to_tail_thread (lwt_t thread, struct list * thread_queue)
{
    list_insert(thread_queue, &thread->linked_list);
}

static inline void
__add_to_head_thread (lwt_t thread, struct list * thread_queue)
{
    list_insert(thread_queue->next, &thread->linked_list);
}

static inline void
__remove_from_thread_queue(lwt_t thread)
{
    (thread->linked_list.prev)->next = thread->linked_list.next;
    (thread->linked_list.next)->prev = thread->linked_list.prev;
}

/* below functions are customized linked list operation for a global channel queue */
static inline void
__add_to_tail_chan_queue (lwt_chan_t chan, struct list * chan_queue)
{
    list_insert(chan_queue, &chan->chan_queue);
}

static inline void
__remove_from_chan_queue(lwt_chan_t chan)
{
    (chan->chan_queue.prev)->next = chan->chan_queue.next;
    (chan->chan_queue.next)->prev = chan->chan_queue.prev;
}

/* below functions are customized linked list operation for a channel's sender queue */
static inline void
__add_to_tail_chan (lwt_t thread, struct list * sender_queue)
{
    list_insert(sender_queue, &thread->sender_queue);
}

static inline void
__remove_from_queue_chan(lwt_t thread)
{
    (thread->sender_queue.prev)->next = thread->sender_queue.next;
    (thread->sender_queue.next)->prev = thread->sender_queue.prev;
}

/* initiate a struct of lwt */
static inline void
__init_thread(lwt_t created_thread)
{
    created_thread->lwt_id = lwt_counter ++;
    created_thread->status = LWT_STATUS_RUNNABLE;
    created_thread->merge_to = NULL;
    created_thread->last_word = NULL;
}

/* --------------- Major thread-function implementations --------------- */

/* pause one thread, start executing the next one */
static inline void
__lwt_dispatch(struct _lwt_context * curr, struct _lwt_context * next)
{
    __asm__ __volatile__
    (
	 "push %%ebx;"
	 "push %%edi;"
	 "push %%esi;"
     "movl %%esp,%0;"
     "movl $retDispatch%=,%1;"
     "movl %2,%%esp;"
     "jmp *%3;"
     "retDispatch%=:;"
	 "pop %%esi;"
	 "pop %%edi;"
	 "pop %%ebx;"
     :"=m" (curr->sp),"=m" (curr->ip)
     :"m"(next->sp),"m" (next->ip)
     );
}

/* find one runnable thread and execute it */
inline void
__lwt_schedule ()
{
    old_thread = current_thread;
    current_thread = (lwt_t)((int)run_queue.next-offset_thread);
    printd("thread %d start executing from reschedule\n", current_thread->lwt_id);
    __lwt_dispatch(&(old_thread->context), &(current_thread->context));
}


/* initialize the library */
void
__initiate()
{
    current_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
    __init_thread(current_thread);
    
    /* initialize run_queue */
    list_init(&run_queue);
    
    /* initialize block_queue */
    list_init(&block_queue);
    
    /* initialize recycle queue */
    list_init(&recycle_queue);
    
    /* initialize zombie_queue */
    list_init(&zombie_queue);

    /* initialize working channel queue */
    list_init(&chan_working);

    /* initialize dead channel queue */
    list_init(&chan_dead);
    
    __add_to_tail_thread(current_thread, &run_queue);
    printd("initialization complete\n");
    
}

/* create a thread, return its lwt_t pointer */
lwt_t
lwt_create(lwt_fn_t fn, void * data)
{
    lwt_t next_thread;
    uint _sp;
    
    if (recycle_queue.next != &recycle_queue) {
        /* recycle queue is not empty */
        next_thread = (lwt_t)((int)recycle_queue.next-offset_thread);
        __remove_from_thread_queue(next_thread);
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
    
    __add_to_tail_thread(next_thread, &run_queue);
    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void
lwt_die(void * message)
{
    printd("die function start executing for thread %d.\n", current_thread->lwt_id);
    
    current_thread->last_word = message;
    
    /* if someone is waiting to join this one, return and go to recycle queue */
    if (current_thread->merge_to)
    {
        current_thread->merge_to->status = LWT_STATUS_RUNNABLE;
        current_thread->merge_to->last_word = message;
        
        __remove_from_thread_queue(current_thread->merge_to);
        __add_to_tail_thread(current_thread->merge_to, &run_queue);
        
        current_thread->status = LWT_STATUS_ZOMBIES;
        __remove_from_thread_queue(current_thread);
        __add_to_tail_thread(current_thread, &recycle_queue);
        
        printd("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
    }
    /* nobody is currently waiting to join this one, becomes a zombie */
    else
    {
        current_thread->status = LWT_STATUS_ZOMBIES;
        __remove_from_thread_queue(current_thread);
        __add_to_tail_thread(current_thread, &zombie_queue);
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
    if (yield_to == current_thread || (yield_to && yield_to->status != LWT_STATUS_RUNNABLE))
    {
        printd("thread %d is yielding to itself or it is not runable\n",current_thread->lwt_id);
        return 0;
    }
    /* yield to NULL */
    if (yield_to)
    {
        __remove_from_thread_queue(yield_to);
        __add_to_head_thread(yield_to, &run_queue);
    }
    __remove_from_thread_queue(current_thread);
    __add_to_tail_thread(current_thread, &run_queue);
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
    if(thread_to_wait->status == LWT_STATUS_ZOMBIES)
    {
        printd("current thread is collecting a zombie thread\n");
        __remove_from_thread_queue(thread_to_wait);
        __add_to_tail_thread(thread_to_wait, &recycle_queue);
        return thread_to_wait->last_word;
    }
    /* update both thread */
    thread_to_wait->merge_to = current_thread;
    
    printd("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
    
    current_thread->status = LWT_STATUS_BLOCKED;
    current_thread->block_for = BLOCKED_JOIN;
    
    /* Move to blocked queue */
    __remove_from_thread_queue(current_thread);
    __add_to_tail_thread(current_thread, &block_queue);
    
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

/* initiate a channel */
void
__init_chan(lwt_chan_t chan)
{
    chan->receiver = current_thread;
    chan->sender_count = 0;
    chan->chan_id = chan_counter++;
    list_init(&(chan->sender_queue));
    __add_to_tail_chan_queue (chan, &chan_working);
}

/* create a thread with initial channel, receiver become created thread, creator thread become sender */
lwt_t
lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t chan)
{
    lwt_t created_thread = lwt_create((void *)fn, (void *)chan);
    chan -> receiver = created_thread;
    chan-> sender_count+=1;
    printd("thread %d has created thread %d with channel %d.\n", current_thread->lwt_id, created_thread->lwt_id,chan->chan_id);
    return created_thread;
}
/* create a channel, current_thread is the receiver */
lwt_chan_t
lwt_chan(int size)
{
    lwt_chan_t chan;
    if (chan_dead.next!= &chan_dead)
    {
        chan = (lwt_chan_t)((int)chan_dead.next-offset_chan);
        __remove_from_chan_queue(chan);
        printd("create one channel from dead channel pool.\n");
    }
    else
    {
        chan = (lwt_chan_t)malloc(sizeof(struct lwt_channel));
    }
    __init_chan(chan);
    printd("thread %d has created channel %d.\n", current_thread->lwt_id, chan->chan_id);
    return chan;
}

/* dereference a channel, announce this channel is no longer used by the caller thread */
void
lwt_chan_deref (lwt_chan_t chan)
{
    if (chan->receiver == current_thread)
    {
        chan->receiver = NULL;
        printd("thread %d is nolonger receiver of channel %d.\n", current_thread->lwt_id, chan->chan_id);
    }
    else chan->sender_count--;
    printd("thread %d has de-ref channel %d, sender left: %d.\n", current_thread->lwt_id, chan->chan_id, chan->sender_count);
    if (chan->sender_count == 0 && chan->receiver == NULL) {
        printd("channel %d has been freed from memory.\n", chan->chan_id);
        __remove_from_chan_queue(chan);
        __add_to_tail_chan_queue (chan, &chan_dead);
    }
}

/* send data through a channel, block sender until receiver received the data */
int
lwt_snd(lwt_chan_t chan, void * data)
{
    if (chan->receiver == NULL)
    {
        printd("thread %d has send data to channel %d, but no receiver.\n", current_thread->lwt_id, chan->chan_id);
        return -1;
    }
    current_thread->message_data = data;
    printd("current_thread: %d, channel: %d\n", current_thread->lwt_id, chan->chan_id);
    __add_to_tail_chan(current_thread, &(chan->sender_queue));
    __remove_from_thread_queue(current_thread);
    __add_to_tail_thread(current_thread, &block_queue);
    current_thread->status = LWT_STATUS_BLOCKED;
    current_thread->block_for = BLOCKED_SENDING;
    printd("thread %d is waiting for channel %d's receiver thread %d.\n", current_thread->lwt_id, chan->chan_id, chan->receiver->lwt_id);
    if (chan->receiver->status == LWT_STATUS_BLOCKED && chan->receiver->block_for == BLOCKED_RECEIVING)
    {
        chan->receiver->status = LWT_STATUS_RUNNABLE;
        __remove_from_thread_queue(chan->receiver);
        __add_to_head_thread(chan->receiver, &run_queue);
    printd("thread %d wake up and ready to receive data from channel %d.\n", chan->receiver->lwt_id, chan->chan_id);
    }
    __lwt_schedule();
    return 0;
}

/* receive data from a channel, if no sender queueing, block the thread and wait till data sent by the sender */
void *
lwt_rcv(lwt_chan_t chan)
{
    if (chan->sender_count == 0)
    {
        printd("thread %d is receiving from channel %d with no sender.\n", current_thread->lwt_id, chan->chan_id);
        return NULL;
    }
    void * result;
    if (chan->sender_queue.next == &(chan->sender_queue))
    {
        printd("thread %d is receiving channel %d, no sender yet.\n", current_thread->lwt_id, chan->chan_id);
        current_thread->status = LWT_STATUS_BLOCKED;
        current_thread->block_for = BLOCKED_RECEIVING;
        __remove_from_thread_queue(current_thread);
        __add_to_tail_thread(current_thread, &block_queue);
        __lwt_schedule();
    }
    printd("thread %d resumed to receive data from channel %d.\n", current_thread->lwt_id, chan->chan_id);
    lwt_t sender = (lwt_t)( (int) (chan->sender_queue.next)-offset_sender);
    sender->status = LWT_STATUS_RUNNABLE;
    result = sender->message_data;
    __remove_from_thread_queue(sender);
    __add_to_head_thread(sender, &run_queue);
    __remove_from_queue_chan(sender);
    return result;
}

/* send a channel through a channel */
int lwt_snd_chan(lwt_chan_t through, lwt_chan_t sending)
{
    int return_value = lwt_snd(through, (void *) sending);
    sending->sender_count = return_value? sending->sender_count:sending->sender_count+1;
    return return_value;
}

/* receive a channel from a channel, the receiver can access the sending channel, so it becomes a sender of it */
lwt_chan_t lwt_rcv_chan(lwt_chan_t chan)
{
    return (lwt_chan_t)lwt_rcv(chan);
}

/* --------------- internal function for user level debugging --------------- */

/* get a queue size */
int
__get_queue_size(struct list * input_list)
{
    int cnt = 0;
    struct list * curr = input_list->next;
    while (curr!=input_list)
    {
        cnt++;
        curr=curr->next;
    }
    return cnt;
}

/* get the size of blocked thread with a particular block reason */
int
__get_blocked_queue_size(enum block_reason block_for)
{
    int cnt = 0;
    struct list * curr = block_queue.next;
    while (curr!=(&block_queue)) 
    {
        if(((lwt_t) ((int)curr-offset_thread))->block_for == block_for) cnt++;
        curr=curr->next;
    }
    return cnt;
}

/* print the content of a thread queue */
void
__print_a_thread_queue(struct list * list_to_print)
{
    struct list * curr = list_to_print->next;
    while (curr!=list_to_print)
    {
        if (list_to_print == &block_queue)
        {
            printf("thread %d blocked with reason: ",((lwt_t)((int)curr-offset_thread))->lwt_id);
            if (((lwt_t)((int)curr-offset_thread))->block_for == BLOCKED_JOIN) printf("joining.\n");
            else if (((lwt_t)((int)curr-offset_thread))->block_for == BLOCKED_RECEIVING) printf("receiving.\n");
            else printf("sending.\n");
        }
        else printf("thread %d.\n",((lwt_t)((int)curr-offset_thread))->lwt_id);
        curr=curr->next;
    }
}

/* print the content of a channel queue */
void
__print_a_chan_queue(struct list * list_to_print)
{
    struct list * curr = list_to_print->next;
    while (curr!=list_to_print)
    {
        printf("channel %d.\n",((lwt_chan_t)((int)curr-offset_chan))->chan_id);
        curr=curr->next;
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
            return __get_queue_size(&block_queue);
        case LWT_INFO_NTHD_ZOMBIES:
            return __get_queue_size(&zombie_queue);
        case LWT_INFO_NTHD_RECYCLE:
            return __get_queue_size(&recycle_queue);
        case LWT_INFO_NCHAN:
            return __get_queue_size(&chan_working);
        case LWT_INFO_DCHAN:
            return __get_queue_size(&chan_dead);
        case LWT_INFO_NSNDING:
            return __get_blocked_queue_size(BLOCKED_SENDING);
        case LWT_INFO_NRCVING:
            return __get_blocked_queue_size(BLOCKED_RECEIVING);
        case LWT_INFO_NJOINING:
            return __get_blocked_queue_size(BLOCKED_JOIN);
        default:
            printf("cannot identify printing instructions\n");
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
            printf("runnable queue showed as below: \n");
            __print_a_thread_queue(&run_queue);
            break;
        case LWT_INFO_NTHD_BLOCKED:
            printf("blocked queue showed as below: \n");
            __print_a_thread_queue(&block_queue);
            break;
        case LWT_INFO_NTHD_ZOMBIES:
            printf("zombie queue showed as below: \n");
            __print_a_thread_queue(&zombie_queue);
            break;
        case LWT_INFO_NTHD_RECYCLE:
            printf("recycle queue showed as below: \n");
            __print_a_thread_queue(&recycle_queue);
            break;
        case LWT_INFO_NCHAN:
            printf("working channel showed as below: \n");
            __print_a_chan_queue(&chan_working);
            break;
        case LWT_INFO_DCHAN:
            printf("dead channel showed as below: \n");
            __print_a_chan_queue(&chan_dead);
            break;
        default:
            printf("cannot identify printing instructions\n");
            break;
    }
}


