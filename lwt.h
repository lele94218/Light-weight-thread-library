#ifndef LWT_H
#define LWT_H
#include "lwt_list.h"

/* turn this on will enable error check for user input */
#ifdef DEBUG
#define printd(format, ...) printf("Line: %05d: "format, __LINE__, ## __VA_ARGS__)
#else
#define printd(format, ...)
#endif


/* define size of stack for created thread */
#define MAX_STACK_SIZE (10 * 1024 * 8)

/* define NULL pointer */
#define LWT_NULL NULL

/* Data type redefinition */
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;
typedef int t_id;
typedef int t_stat;

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
    LWT_STATUS_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_STATUS_BLOCKED,
    /* This is a zombie thread. */
    LWT_STATUS_ZOMBIES,
    LWT_RUNNING
};

/* if status is blocked, this shows reason for blockage */
enum block_reason
{
    /* The thread is running. */
    BLOCKED_JOIN = 0,
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

/* This structure describes a LWT thread. */
struct _lwt_t
{
    /* Linked list node in a global thread queue, this struct position is fixed */
    struct list linked_list_node;

    /* Sender list node, its position at a sender queue */
    struct list sender_queue_node;

    /* Thread id */
    t_id lwt_id;

    /* the status of a thread */
    enum lwt_status state;

    /* the reason for blockage */
    enum block_reason block_for;

    /* thread regarding join, the master who is waiting to collect this thread */
    struct _lwt_t * merge_to;

    /* data sending to other thread */
    void * message_data;

    /* initial stack memory pointer, lowest address */
    unsigned int init_sp;

    /* return value */
    void * last_word;

    /* Thread context */
    struct _lwt_context context;
};
typedef struct _lwt_t * lwt_t;

/* This structure describes a lwt channel */
struct _lwt_channel
{
    /* channel ID */
    int chan_id;

    /* head of linked list, serve as a reference to its sender queue */
    struct list_head sender_queue;

    /* Linked list node, used to find its position in global channel queue */
    struct list chan_queue_node;

    /* number of senders have access to this channel */
    int snd_cnt;

    /* receiver thread */
    struct _lwt_t * receiver;
};
typedef struct _lwt_channel * lwt_chan_t;

/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);
typedef void * (*lwt_chan_fn_t)(lwt_chan_t);

/* Funciton declaration for lwt thread operation */
lwt_t  lwt_create(lwt_fn_t fn, void * data);
void * lwt_join(lwt_t thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t strong_thread);
lwt_t lwt_current();
int lwt_id(lwt_t input_thread);
lwt_t lwt_current();

/* Function declaration for lwt thread channel operation */
lwt_chan_t lwt_chan (int sz);
void lwt_chan_deref (lwt_chan_t c);
int lwt_snd(lwt_chan_t c, void * data);
void *lwt_rcv(lwt_chan_t c);
int lwt_snd_chan(lwt_chan_t c, lwt_chan_t sending);
lwt_chan_t lwt_rcv_chan(lwt_chan_t c);
lwt_t lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t c);

/* debugging function */
void print_queue_content(enum lwt_info_t);
int lwt_info(enum lwt_info_t t);
#endif
