#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

#define thread_context(thread) \
        ((struct _lwt_context *)((char *)(thread)+(uint)(&((lwt_t)0)->context)))

void __initiate (void) __attribute__((constructor));

/* --------------- Global variable --------------- */

/* used for assigning thread id */
int lwt_counter = 0;
int chan_counter = 0;
const int offset_thread = (int)(&(((lwt_t)0)->linked_list));
const int offset_sender = (int)(&(((lwt_t)0)->sender_queue));

/* three queues, one for thread either waiting or running, one for zombies, one for recycle */
struct list valid_queue;
struct list block_queue;
struct list recycle_queue;
struct list zombie_queue;


/* identify threads */
lwt_t current_thread;
lwt_t old_thread;


/* --------------- internal function declarations --------------- */


inline void __lwt_dispatch(struct _lwt_context *curr, struct _lwt_context *next);
void __lwt_schedule (void);
void * __lwt_trampoline(lwt_fn_t fn, void * data);
void __initiate(void);



/* --------------- inline function definition --------------- */

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
    list_insert(thread_queue, &thread->linked_list);
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
    (thread->linked_list.prev)->next = thread->linked_list.next;
    (thread->linked_list.next)->prev = thread->linked_list.prev;
}


/* init a struct of lwt */
static inline void
__init_thread(lwt_t created_thread)
{
    created_thread->lwt_id = lwt_counter ++;
    created_thread->status = LWT_STATUS_RUNNABLE;
    created_thread->merge_to = NULL;
    created_thread->last_word = NULL;
}

/* --------------- Function implementations --------------- */

/* pause one thread, start executing the next one */
inline void
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


/* find one proper thread to execute from pool */
inline void
__lwt_schedule ()
{
    old_thread = current_thread;
    current_thread = (lwt_t)((int)valid_queue.next-offset_thread);
    printd("thread %d start executing from reschedule\n", current_thread->lwt_id);
    __lwt_dispatch(thread_context(old_thread), thread_context(current_thread));
}


/* initialize main thread and the queues when user called create at first time */
void
__initiate()
{
    current_thread = (lwt_t) malloc (sizeof(struct _lwt_t));
    __init_thread(current_thread);
    
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
    lwt_t next_thread;
    uint _sp;
    
    if (recycle_queue.next != &recycle_queue) {
        /* Noempty recycle queue */
        next_thread = (lwt_t)((int)recycle_queue.next-offset_thread);
        __remove_from_queue(next_thread);
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
    
    __add_to_tail(next_thread, &valid_queue);
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
        
        __remove_from_queue(current_thread->merge_to);
        __add_to_tail(current_thread->merge_to, &valid_queue);
        
        current_thread->status = LWT_STATUS_ZOMBIES;
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &recycle_queue);
        
        printd("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
    }
    /* nobody is currently waiting to join this one, becomes a zombie */
    else
    {
        current_thread->status = LWT_STATUS_ZOMBIES;
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
        __remove_from_queue(yield_to);
        __add_to_head(yield_to, &valid_queue);
    }
    
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &valid_queue);
    __lwt_schedule();
    
    return 0;
}

/* blocked and wait for the argument thread, when argument thread ends, resume execution and return message from the dead thread */
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
        __remove_from_queue(thread_to_wait);
        __add_to_tail(thread_to_wait, &recycle_queue);
        return thread_to_wait->last_word;
    }
    /* update both thread */
    thread_to_wait->merge_to = current_thread;
    
    printd("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
    
    current_thread->status = LWT_STATUS_BLOCKED;
    
    /* Move to blocked queue */
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &block_queue);
    
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

/* return the informatin of current thread status */
int
lwt_info(enum lwt_info_t t)
{
    int cnt = 0;
    struct list * current;
    struct list * head;
    
    switch (t) {
        case LWT_INFO_NTHD_ZOMBIES:
            current = zombie_queue.next;
            head = &zombie_queue;
            break;
            
        case LWT_INFO_NTHD_BLOCKED:
            current = block_queue.next;
            head = &block_queue;
            break;
            
        default:
            current = valid_queue.next;
            head = &valid_queue;
            break;
    }
    
    while (current != head)
    {
        cnt ++;
        current = current->next;
    }
    return cnt;
}

/* Below functions are related to thread communication */

/* add a thread to tail of a thread queue */
static inline void
__add_to_tail_chan (lwt_t thread, struct list * sender_queue)
{
    list_insert(sender_queue, &thread->sender_queue);
}

/* add a thread to head of a thread queue */
static inline void
__add_to_head_chan (lwt_t thread, struct list * sender_queue)
{
    list_insert(sender_queue->next, &thread->sender_queue);
}

/* remove a thread from a queue */
static inline void
__remove_from_queue_chan(lwt_t thread)
{
    (thread->sender_queue.prev)->next = thread->sender_queue.next;
    (thread->sender_queue.next)->prev = thread->sender_queue.prev;
}

/* create a thread with initial channel */
lwt_t lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t chan)
{
    lwt_t created_thread = lwt_create((void *)fn, (void *)chan);
    chan -> receiver = created_thread;
    chan->sender_count+=1;
    chan -> reference_counter += 1;
    return created_thread;
}
/* create a channel in the current thread */
lwt_chan_t lwt_chan(int size)
{
    lwt_chan_t chan=(lwt_chan_t)malloc(sizeof(struct lwt_channel));
    chan->receiver=current_thread;
    chan->sender_count=0;
    chan->reference_counter=1;
    chan->chan_id=chan_counter++;
    printf("thread %d has created channel %d.\n", current_thread->lwt_id, chan->chan_id);
    return chan;
}

void lwt_chan_deref (lwt_chan_t chan)
{
    if (chan->receiver==current_thread)
    {
        chan->receiver==NULL;
        printf("thread %d is nolonger receiver of channel %d.\n", current_thread->lwt_id, chan->chan_id);
    }
    else chan->sender_count--;
    printf("thread %d has de-ref channel %d, sender left: %d.\n", current_thread->lwt_id, chan->chan_id, chan->sender_count);
    if (chan->sender_count == 0&&chan->receiver==NULL) {
        free(chan);
    }
}

int lwt_snd(lwt_chan_t chan, void * data)
{
    if (chan->receiver==NULL)
    {
        return -1;
    }
    current_thread->message_data=data;
    __add_to_tail_chan(current_thread, &(chan->sender_queue));
    current_thread->status = LWT_STATUS_BLOCKED;
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &block_queue);
    __lwt_schedule();
    return 0;
}

void *lwt_rcv(lwt_chan_t c)
{
    void * result;
    if (c->sender_queue.next!=&(c->sender_queue)) {
        lwt_t sender = ((lwt_t)((int)(c->sender_queue.next)-offset_sender));
        sender->status = LWT_STATUS_RUNNABLE;
        result = sender->message_data;
        sender->message_data = NULL;
        __remove_from_queue_chan(sender);
        return result;
    }
    else
    {
        current_thread->status = LWT_STATUS_BLOCKED;
        __add_to_tail(current_thread, &block_queue);
        __lwt_schedule();
    }
    return  NULL;
}

int lwt_snd_chan(lwt_chan_t c, lwt_chan_t sending)
{return 0;}

lwt_chan_t lwt_rcv_chan(lwt_chan_t c)
{return NULL;}




