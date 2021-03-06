#include "lwt.h"
#include "umalloc.h"

struct __func_param
{
    lwt_fn_t func;
    void *data;
};


/* --------------- Thread communication function implementation, channelling --------------- */

void __print_a_chan_queue(struct list_head *);

/* --------------- Internal function declaration --------------- */
int __get_queue_size(struct list_head *);
int lwt_sync_snd(lwt_chan_t chan, void *data);
void *lwt_sync_rcv(lwt_chan_t chan);

/* --------------- initialization function --------------- */

/* initiate a channel */
static void inline __init_chan(lwt_chan_t chan, int size)
{
    chan->size = size;
    chan->buffer.data_buffer = umalloc(size * sizeof(uint));
    chan->buffer.tail = chan->buffer.head = 0;
    chan->type = LOCAL_CHAN;
    chan->receiver = lwt_current();
    chan->snd_cnt = 0;
    chan->chan_id = chan_counter;
    ps_faa(&chan_counter,1);
    list_head_init(&(chan->sender_queue));
}

/* create a thread with initial channel, receiver become created thread, creator thread become sender */
lwt_t lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t chan)
{
    lwt_t created_thread = lwt_create((void *)fn, (void *)chan, 0);
    chan->snd_cnt += 1;
    printd("thread %d has created thread %d with channel %d for user.\n", lwt_current()->lwt_id, created_thread->lwt_id, chan->chan_id);
    return created_thread;
}

void set_chan_type(lwt_chan_t chan, enum chan_type type)
{
    chan->type = type;
}

/* create a channel, current_thread is the receiver */
lwt_chan_t
lwt_chan(int size)
{
    lwt_chan_t chan;
    chan = (lwt_chan_t)umalloc(sizeof(struct _lwt_channel));
    __init_chan(chan, size);
    printd("thread %d has created channel %d.\n", lwt_current()->lwt_id, chan->chan_id);
    return chan;
}

/* dereference a channel, announce this channel is no longer used by the caller thread */
void lwt_chan_deref(lwt_chan_t chan)
{
    if (unlikely(chan->receiver == lwt_current()))
    {
        chan->receiver = NULL;
        printd("thread %d is nolonger receiver of channel %d.\n", lwt_current()->lwt_id, chan->chan_id);
    }
    else
        chan->snd_cnt--;

    /* TODO: recycle channel buffer. */
    printd("thread %d has de-ref channel %d, sender left: %d.\n", lwt_current()->lwt_id, chan->chan_id, chan->snd_cnt);
    if (chan->snd_cnt == 0 && chan->receiver == NULL)
    {
        printd("channel %d has been freed from memory.\n", chan->chan_id);
        ufree(chan);
    }
}

/* block the thread and yield */
void __block_thread(lwt_t thread, enum block_status block_for, lwt_chan_t chan)
{
    list_rem_d(thread);
    if (block_for == BLOCKED_RECEIVING)
    {
        kthds[current_kthd].nrcving++;
    }
    else
    {
        list_head_add_d(&(chan->sender_queue), thread);
        kthds[current_kthd].nsnding++;
    }
    thread->state = LWT_BLOCKED;
    thread->block_for = block_for;
    kthds[current_kthd].block_counter++;
    lwt_yield(NULL);
}

void __resume_thread(lwt_t thread)
{
    kthds[current_kthd].nrcving -= thread->block_for == BLOCKED_RECEIVING ? 1 : 0;
    kthds[current_kthd].nsnding -= thread->block_for == BLOCKED_SENDING ? 1 : 0;
    //if(thread->block_for==BLOCKED_SENDING) list_rem_d(thread);
    list_rem_d(thread);
    thread->state = LWT_RUNNABLE;
    kthds[current_kthd].block_counter--;
    // list_head_append_d(current_run_queue(), thread);
    list_head_append_d(owner_run_queue(), thread);
}

/* send data through a channel, block sender until receiver received the data */
int lwt_snd(lwt_chan_t chan, void *data)
{
    if (chan->type == GLOBAL_CHAN)
    {
        set_chan_type(chan, GLOBAL_CHAN);
        return lwt_sync_snd(chan, data);
    }
    lwt_t current_thread = lwt_current();
    if (unlikely(chan->receiver == NULL))
    {
        printd("thread %d has send data: %d to channel %d, but no receiver.\n", current_thread->lwt_id, (int)data, chan->chan_id);
        return -1;
    }

    if (chan->receiver->state == LWT_BLOCKED && chan->receiver->block_for == BLOCKED_RECEIVING && chan->receiver->now_rcving == chan)
    {
        /* someone is waiting */
        chan->receiver->message_data = data;
        printd("thread %d has send data %d to channel %d and it has recevier thread %d.\n", current_thread->lwt_id, (int)data, chan->chan_id, chan->receiver->lwt_id);
        __resume_thread(chan->receiver);
        printd("thread %d done sending data: %d and keep running.\n", current_thread->lwt_id, (int)data);

        return 0;
    }

    chan->ready = 1;
    if (chan->cgroup && (chan->cgroup->blocked))
    {
        __resume_thread(chan->cgroup->owner);
    }
    if (chan->buffer.tail - chan->buffer.head != chan->size)
    {
        /* buffer is not full */
        ((uint *)(chan->buffer.data_buffer))[chan->buffer.tail++ % chan->size] = (uint)data;
        printd("thread %d put data: %d on chan %d's buffer at location %d\n", current_thread->lwt_id, ((uint *)(chan->buffer.data_buffer))[chan->buffer.tail - 1], chan->chan_id, chan->buffer.tail);
        return 0;
    }

    /* buffer doesn't have space */
    current_thread->message_data = data;
    printd("thread: %d block for sending on channel: %d buffer doesn't have space. \n", current_thread->lwt_id, chan->chan_id);
    __block_thread(current_thread, BLOCKED_SENDING, chan);

    return 0;
}

int lwt_sync_snd(lwt_chan_t chan, void *data)
{
    int remote_thdid = chan->receiver->owner_kthd;
    lwt_t current_thread = lwt_current();

    cas_lock(&chan->rb_occupied);
    ((uint *)(chan->buffer.data_buffer))[chan->buffer.tail++ % chan->size] = (uint)data;
    printd("thread %d put data: %d on chan %d's buffer at location %d\n", current_thread->lwt_id, ((uint *)(chan->buffer.data_buffer))[chan->buffer.tail - 1], chan->chan_id, chan->buffer.tail);
    cas_unlock(&chan->rb_occupied);
    
    cas_lock(&(kthds[remote_thdid].wq_occupied));
    //write data
    struct __lwt_wrap * lw = umalloc(sizeof(struct __lwt_wrap));
    lw->thd = chan->receiver;
    list_head_add_d(&(kthds[remote_thdid].wakeup_queue), lw);
    cas_unlock(&(kthds[remote_thdid].wq_occupied));

    // if (chan->receiver->state == LWT_BLOCKED && chan->receiver->block_for == BLOCKED_RECEIVING && chan->receiver->now_rcving == chan)
    // {
    //     //sl_cs_enter();
    //     /* someone is waiting */
    //     list_rem_d(chan->receiver);
    //     cas_lock(&(kthds[remote_thdid].wq_occupied));
    //     list_head_add_d(&(kthds[remote_thdid].wakeup_queue), chan->receiver);
    //     /* add remote kernel thread polling flag */
    //     kthds[remote_thdid].polling_flag = 1;
    //     cas_unlock(&(kthds[remote_thdid].wq_occupied));
    //     /* wake up remote kthd, if it is blocked */
    //     sl_thd_wakeup(remote_thdid);
            
    //         //sl_cs_exit();
    //     }

    //     return 0;
    // }
    // cas_unlock(&chan->rb_occupied);

    // /* buffer is full, add to sender queue and block */

    // list_rem_d(current_thread);

    // //chl_sq_lock(chan);
    // list_head_add_d(&(chan->sender_queue), current_thread);
    // //cas_unlock(chan);
    
    // kthds[current_kthd].nsnding++;
    // current_thread->state = LWT_BLOCKED;
    // current_thread->block_for = BLOCKED_SENDING;
    // kthds[current_kthd].block_counter++;

    // lwt_yield(NULL);

    return 0;
}

/* receive data from a channel, if no sender queueing, block the thread and wait till data sent by the sender */
void *
lwt_rcv(lwt_chan_t chan)
{
    if (chan->type == GLOBAL_CHAN)
    {
        return lwt_sync_rcv(chan);
    }
    void *result;
    lwt_t current_thread = lwt_current();
    /* receive data from buffer */
    if (chan->buffer.tail - chan->buffer.head != 0)
    {
        result = (void *)(((uint *)(chan->buffer.data_buffer))[(chan->buffer.head++) % chan->size]);
        printd("thread %d has received data %d from channel %d.\n", current_thread->lwt_id, (int)result, chan->chan_id);

        /* sender queue not empty, free one, move its data to buffer */
        if (!list_head_empty(&(chan->sender_queue)))
        {
            lwt_t sender = list_head_first_d(&(chan->sender_queue), struct _lwt_t);
            __resume_thread(sender);

            ((uint *)(chan->buffer.data_buffer))[(chan->buffer.tail++) % chan->size] = (uint)(sender->message_data);
            printd("sender %d has been freed and wrote data %d to channel %d.\n", sender->lwt_id, (int)sender->message_data, chan->chan_id);
        }

        /* update channel status */
        chan->ready = chan->buffer.head == chan->buffer.tail ? 0 : 1;
        printd("now channel %d status is %d.\n", chan->chan_id, chan->ready);
        return result;
    }

    /* receive data from sender queue */
    if (!list_head_empty(&(chan->sender_queue)))
    {
        lwt_t sender = list_head_first_d(&(chan->sender_queue), struct _lwt_t);
        result = sender->message_data;
        printd("thread %d is receiving data %d from channel %d.\n", current_thread->lwt_id, (int)result, chan->chan_id);
        __resume_thread(sender);
        chan->ready = list_head_empty(&(chan->sender_queue)) ? 0 : 1;
        return result;
    }

    /* block it self */
    printd("thread %d is receiving at channel: %d but waiting for a sender.\n", current_thread->lwt_id, chan->chan_id);
    current_thread->now_rcving = chan;
    __block_thread(current_thread, BLOCKED_RECEIVING, chan);
    return current_thread->message_data;
}

void *
lwt_sync_rcv(lwt_chan_t chan)
{
    void *result;
    lwt_t current_thread = lwt_current();
    int remote_thdid = chan->receiver->owner_kthd;

    while (1)
    {

        //chl_rb_lock(chan);
        if (chan->buffer.tail - chan->buffer.head != 0)
        {
            /* if buffer has data */
            result = (void *)(((uint *)(chan->buffer.data_buffer))[(chan->buffer.head++) % chan->size]);
            
            //chl_sq_lock(chan);
            // if (!list_head_empty(&(chan->sender_queue)))
            // {
            //     lwt_t sender = list_head_first_d(&(chan->sender_queue), struct _lwt_t);
            //     //chl_sq_unlock(chan);
            //     /* move sender to its remote kernel thread wake up queue */
            //     list_rem_d(sender);
            //     list_head_add_d(&(kthds[remote_thdid].wakeup_queue), sender);
                
            //     /* wake up remote kthd, if it is blocked */
            //     sl_thd_wakeup(remote_thdid);

            //     kthds[remote_thdid].polling_flag = 1;
            //     ((uint *)(chan->buffer.data_buffer))[(chan->buffer.tail++) % chan->size] = (uint)(sender->message_data);
            //     //chl_rb_unlock(chan);
            // }
            //chl_sq_unlock(chan);

            return result;
        }
        //chl_rb_unlock(chan);

        /* if buffer is empty, block it.  */
        current_thread->now_rcving = chan;
        list_rem_d(current_thread);
        kthds[current_kthd].nrcving++;
        current_thread->state = LWT_BLOCKED;
        current_thread->block_for = BLOCKED_RECEIVING;
        kthds[current_kthd].block_counter++;
        lwt_yield(NULL);
    }
}

/* send a channel through a channel */
int lwt_snd_chan(lwt_chan_t through, lwt_chan_t sending)
{
    int return_value = lwt_snd(through, (void *)sending);
    /* in case the reciever thread is blocked. */
    lwt_yield(NULL);
    return return_value;
}

/* receive a channel from a channel, the receiver can access the sending channel, so it becomes a sender of it */
lwt_chan_t
lwt_rcv_chan(lwt_chan_t chan)
{
    lwt_chan_t rec = lwt_rcv(chan);
    if (rec)
    {
        rec->snd_cnt++;
    }
    return rec;
}

/* create a channel group */
lwt_cgrp_t
lwt_cgrp(void)
{
    lwt_cgrp_t cgrp = umalloc(sizeof(struct _lwt_cgrp));
    if (!cgrp)
        return LWT_NULL;
    list_head_init(&cgrp->chl_list);
    cgrp->owner = lwt_current();
    cgrp->blocked = 0;
    printd("channel group created \n");
    return cgrp;
}

/* add a channel to a channel group */
int lwt_cgrp_add(lwt_cgrp_t cgrp, lwt_chan_t chan)
{
    if (chan->cgroup)
    {
        return -1;
    }
    list_head_append_d(&cgrp->chl_list, chan);
    chan->cgroup = cgrp;
    printd("channel %d added to channel group \n", chan->chan_id);
    return 0;
}

/* remove a channel from a channel group */
int lwt_cgrp_rem(lwt_cgrp_t cgrp, lwt_chan_t chan)
{
    if (chan->ready)
    {
        return 1;
    }
    if (chan->cgroup != cgrp)
    {
        return -1;
    }
    list_rem_d(chan);
    chan->cgroup = NULL;
    return 0;
}

/* free a channel group */
int lwt_cgrp_free(lwt_cgrp_t cgrp)
{
    lwt_chan_t node = NULL;

    list_foreach_d(&cgrp->chl_list, node)
    {
        if (node->ready == 1)
            printd("tried to free a group but failed because not empty! \n");
        return -1;
    }

    node = NULL;
    list_foreach_d(&cgrp->chl_list, node)
    {
        node->cgroup = NULL;
    }

    ufree(cgrp);
    printd("a group has been freed! \n");
    return 0;
}

/* current thread waits on the channel group*/
lwt_chan_t
lwt_cgrp_wait(lwt_cgrp_t cgrp)
{
    lwt_t current_thread = lwt_current();
    if (list_head_empty(&cgrp->chl_list))
    {
        printd("thread %d is waiting for a group with no channel.\n", current_thread->lwt_id);
        return NULL;
    }
    printd("wait on channel group \n");
    lwt_chan_t chan = NULL;
    while (1)
    {
        list_foreach_d(&cgrp->chl_list, chan)
        {
            printd("channel %d with status %d\n.", chan->chan_id, chan->ready);
            if (chan->ready == 1)
            {
                cgrp->blocked = 0;
                printd("exit waiting from a channel group with channel %d returned.\n", chan->chan_id);
                return chan;
            }
        }
        cgrp->blocked = 1;
        list_rem_d(current_thread);
        kthds[current_kthd].block_counter++;
        kthds[current_kthd].nrcving++;
        current_thread->state = LWT_BLOCKED;
        cgrp->blocked = 1;
        current_thread->block_for = BLOCKED_RECEIVING;
        lwt_yield(NULL);
    }
}

/* set the mark to the channel */
void lwt_chan_mark_set(lwt_chan_t chan, void *mark)
{
    printd("set chan: %d with mark %d\n", chan->chan_id, (int)mark);
    chan->mark = mark;
}

/* get the mark of the channel */
void *
lwt_chan_mark_get(lwt_chan_t chan)
{
    return chan->mark;
}

/* --------------- kernel thread API --------------- */
void lwt_kthd_trampline(void *ptr)
{
    ((struct __func_param *)ptr)->func((void *)(((struct __func_param *)ptr)->data));
    //lwt_create(((struct __func_param *)ptr)->func, (void *)(((struct __func_param *)ptr)->data), 0);
    ufree(ptr);
    while (1)
    {
        if (__get_queue_size(current_run_queue())==1)
        {
            printc("block kthd: %d!\n", current_kthd);
            /* block kthd */
            sl_thd_block(0);
            sl_thd_yield(NULL);
            __lwt_schedule();
        }
    }
    return;
}

struct sl_thd * lwt_kthd_create(lwt_fn_t fn, lwt_chan_t c, int pri)
{
    printd("-------------\n");
    struct __func_param *__fp = umalloc(sizeof(struct __func_param));
    __fp->func = fn;
    __fp->data = (void *)c;
    struct sl_thd *curr_kthd = sl_thd_alloc((cos_thd_fn_t)lwt_kthd_trampline, (void *)__fp);
    __initiate(curr_kthd->thdid);
    union sched_param sph = {.c = {.type = SCHEDP_PRIO, .value = pri}};
    sl_thd_param_set(curr_kthd, sph.v);
    return curr_kthd;
}

int lwt_snd_thd(lwt_chan_t chan, lwt_t sending)
{
    assert(lwt_current() != sending);
    lwt_snd(chan, (void *)sending);
}

lwt_t lwt_rcv_thd(lwt_chan_t chan)
{
    lwt_t t = (lwt_t)lwt_rcv(chan);
    t->owner_kthd = current_kthd;
    if (t->state == LWT_RUNNING)
    {
        //must wait till it paused to change the true owner ship
    }
    else if (t->state == LWT_RUNNABLE)
    {
        list_rem_d(t);
        list_head_append_d(owner_run_queue(), t);
    }
    else
    {
        //must wait till is resumed and get back to owner run queue
    }
    return t;
}

/* --------------- internal function for user level debugging --------------- */

/* get a queue size */
int __get_queue_size(struct list_head *input_list)
{
    int cnt = 0;
    struct list *curr = (input_list->l).n;
    while (curr != &(input_list->l))
    {
        cnt++;
        curr = curr->n;
    }
    return cnt;
}

/* print the content of a thread queue */
void __print_a_thread_queue(struct list_head *list_to_print)
{
    struct list *curr = (list_to_print->l).n;
    while (curr != &(list_to_print->l))
    {
        printc("thread %d.\n", (container(curr, struct _lwt_t, list_node))->lwt_id);
        curr = curr->n;
    }
}

/* print the content of a channel queue */
void __print_a_chan_queue(struct list_head *list_to_print)
{
    struct list *curr = (list_to_print->l).n;
    while (curr != &(list_to_print->l))
    {
        printd("channel %d.\n", (container(curr, struct _lwt_channel, list_node))->chan_id);
        curr = curr->n;
    }
}

/* --------------- User level debugging functions implementation --------------- */

/* return the informatin of current thread status */
int lwt_info(enum lwt_info_t t)
{
    switch (t)
    {
    case LWT_INFO_NTHD_RUNNABLE:
        return __get_queue_size(current_run_queue());
    case LWT_INFO_NTHD_BLOCKED:
        return kthds[current_kthd].block_counter;
    case LWT_INFO_NTHD_ZOMBIES:
        return kthds[current_kthd].zombie_counter;
    case LWT_INFO_NTHD_RECYCLE:
        return __get_queue_size(current_recycle_queue());
    case LWT_INFO_NSNDING:
        return kthds[current_kthd].nsnding;
    case LWT_INFO_NRCVING:
        return kthds[current_kthd].nrcving;
    default:
        printd("cannot identify printing instructions\n");
        return -1;
    }
}

/* print the content of a queue */
void print_queue_content(enum lwt_info_t input)
{
    switch (input)
    {
    case LWT_INFO_NTHD_RUNNABLE:
        printc("runnable queue showed as below: \n");
        __print_a_thread_queue(current_run_queue());
        break;
    case LWT_INFO_NTHD_RECYCLE:
        printc("recycle queue showed as below: \n");
        __print_a_thread_queue(current_recycle_queue());
        break;
    default:
        printc("cannot identify printing instructions\n");
        break;
    }
}