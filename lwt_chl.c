#include <stdlib.h>
#include <stdio.h>

#include "lwt_list.h"
#include "lwt.h"

extern lwt_t current_thread;
extern struct list_head run_queue;
extern struct list_head recycle_queue;

extern void __lwt_schedule();



/* two channel queues, one for working channel, one for dead channel */
struct list_head chan_working;
struct list_head chan_dead;

int nrcving = 0;
int nsnding = 0;
int chan_counter = 0;

/* used for assigning thread and channel id */
int lwt_counter = 0;
int zombie_counter = 0;
int block_counter = 0;

/* --------------- Thread communication function implementation, channelling --------------- */

void __print_a_chan_queue(struct list_head *);

/* --------------- initialization function --------------- */


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

/* create a thread with initial channel, receiver become created thread, creator thread become sender */
lwt_t
lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t chan)
{
    lwt_t created_thread = lwt_create((void *)fn, (void *)chan, 0);
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
    /* Note: Why block it? */
//    current_thread->state = LWT_STATUS_BLOCKED;
//    current_thread->block_for = BLOCKED_SENDING;
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
    
    nsnding--;
    block_counter--;
    result = sender->message_data;
    
    list_rem_d(sender);
    printd("thread %d is the sender in channel %d \n", sender->lwt_id, chan->chan_id);
    if (sender->state != LWT_STATUS_ZOMBIES)
    {
        printd("runing \n");
        sender->state = LWT_STATUS_RUNNABLE;
        list_head_append_d(&run_queue, sender);
    }
    else
    {
        /* Note: the sender thread is already in the ``zombie queue'' (which doesn't exist) */
        printd("zombie \n");
//        list_head_append_d(&, sender);
    }
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
//__get_blocked_queue_size(enum block_status block_for)
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
