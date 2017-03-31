#ifndef LWT_H
#define LWT_H
#include "lwt_list.h"


/* turn this on will enable error check for user input */
#ifdef DEBUG
#define printd(format, ...) printf("%s Line: %05d: " format, __FILE__, __LINE__, ## __VA_ARGS__)
#else
#define printd(format, ...)
#endif


/* define size of stack for created thread */
#define MAX_STACK_SIZE (100 * 1024 * 8)

/* define NULL pointer */
#define LWT_NULL NULL

/* define prediction */
#define likely(x)   __builtin_expect((x),1)
#define unlikely(x) __builtin_expect((x),0)

/* attributes of the created thread */
#define LWT_NOJOIN 1

/* Data type redefinition */
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;
typedef int t_id;
typedef int t_stat;
typedef int lwt_flags_t;

/* User level info argument type.  */
enum lwt_info_t
{
    /* The thread is running. */
    LWT_INFO_NTHD_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_INFO_NTHD_BLOCKED,
    /* This is a zombie thread. */
    LWT_INFO_NTHD_ZOMBIES,
    /* number of threads waiting to be re-used, not freed yet */
    LWT_INFO_NTHD_RECYCLE,
    /* number of threads blocked sedning */
    LWT_INFO_NSNDING,
    /* number of threads blocked receiving */
    LWT_INFO_NRCVING,
    /* number of threads blocked receiving */
    LWT_INFO_NJOINING,
    /* number of active channels */
    LWT_INFO_NCHAN,
    /* number of dead channels, not freed yet */
    LWT_INFO_DCHAN,
};

/* thread status */
enum lwt_status
{
    /* The thread is running. */
    LWT_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_BLOCKED,
    /* This is a zombie thread. */
    LWT_ZOMBIES,
    /* This thread is currently running. */
    LWT_RUNNING
};

/* if status is blocked, this shows status for blockage */
enum block_status
{
    /* The thread is blocked. */
    BLOCKED_RECEIVING,
    /* This is a zombie thread. */
    BLOCKED_SENDING,
};


/* define the context of a thread */
struct _lwt_context
{
    unsigned int ip, sp;
};

/* buffer ring of the channel*/
struct _buffer_ring
{
    int tail, head, count;
    void * data_buffer;
};

/* channel group */
struct _lwt_cgrp
{
    struct list_head chl_list;
    struct list_head wait_queue;
};
typedef struct _lwt_cgrp * lwt_cgrp_t;

/* This structure describes a lwt channel */
struct _lwt_channel
{
    /* channel ID */
    int chan_id;
    
    /* head of linked list, serve as a reference to its sender queue */
    struct list_head sender_queue;
    
    /* Linked list node, used to find its position in global channel queue */
    struct list list_node;
    
    struct list cglist;
    
    /* number of senders have access to this channel */
    int snd_cnt;
    
    /* receiver thread */
    struct _lwt_t * receiver;
    
    /* buffer ring */
    struct _buffer_ring buffer;

    /* channel buffer size */
    int size;
    
    /* channel group need??*/
    lwt_cgrp_t cgroup;
    
    /* if there is a event */
    int ready;
    
    /* synchronous data */
    void * syn_data;

    /* mark of the channel*/
    void * mark;
};
typedef struct _lwt_channel * lwt_chan_t;



/* This structure describes a LWT thread. */
struct _lwt_t
{

    struct list list_node;

    /* Thread id */
    t_id lwt_id;

    /* the status of a thread */
    enum lwt_status state;

    /* the reason for blockage */
    enum block_status block_for;

    /* parent thread */
    struct _lwt_t * parent;

    /* data sending to other thread */
    void * message_data;

    /* initial stack memory pointer, lowest address */
    unsigned int init_sp;

    /* return value */
//    void * last_word;

    /* Thread context */
    struct _lwt_context context;
    
    lwt_chan_t chl;
    
    /* thread join state */
    int nojoin;
};
typedef struct _lwt_t * lwt_t;


/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);
typedef void * (*lwt_chan_fn_t)(lwt_chan_t);




/* --------------------------- Funciton declaration for lwt thread operation --------------------------- */
lwt_t  lwt_create(lwt_fn_t fn, void * data, lwt_flags_t flags);
void * lwt_join(lwt_t thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t strong_thread);
lwt_t lwt_current();
int lwt_id(lwt_t input_thread);
lwt_t lwt_current();

/* --------------------------- Function declaration for lwt thread channel operation --------------------------- */
lwt_chan_t lwt_chan (int sz);
void lwt_chan_deref (lwt_chan_t c);
int lwt_snd(lwt_chan_t c, void * data);
void *lwt_rcv(lwt_chan_t c);
int lwt_snd_chan(lwt_chan_t c, lwt_chan_t sending);
lwt_chan_t lwt_rcv_chan(lwt_chan_t c);
lwt_t lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t c);

lwt_cgrp_t lwt_cgrp (void);
int lwt_cgrp_free (lwt_cgrp_t cgrp);
int lwt_cgrp_add (lwt_cgrp_t cgrp, lwt_chan_t chan);
int lwt_cgrp_rem(lwt_cgrp_t cgrp, lwt_chan_t chan);
lwt_chan_t lwt_cgrp_wait (lwt_cgrp_t cgrp);

void lwt_chan_mark_set(lwt_chan_t, void *);
void *lwt_chan_mark_get(lwt_chan_t);

/* --------------------------- debugging function --------------------------- */
void print_queue_content(enum lwt_info_t);
int lwt_info(enum lwt_info_t t);
#endif
