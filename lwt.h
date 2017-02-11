#ifndef LWT_H
#define LWT_H


/* turn this on will enable error check for user input */

#ifdef DEBUG
#define printd(format, ...) printf("Line: %05d: "format, __LINE__, ##__VA_ARGS__)
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




/* User info argument type.  */
enum lwt_info_t
{
    /* The thread is running. */
    LWT_INFO_NTHD_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_INFO_NTHD_BLOCKED,
    /* This is a zombie thread. */
    LWT_INFO_NTHD_ZOMBIES, 
    /* number of active channels */
    LWT_INFO_NCHAN, 
    /* number of threads blocked sedning */
    LWT_INFO_NSNDING, 
    /* number of threads blocked receiving */
    LWT_INFO_NRCVING
};

enum lwt_status
{
    /* The thread is running. */
    LWT_STATUS_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_STATUS_BLOCKED,
    /* This is a zombie thread. */
    LWT_STATUS_ZOMBIES
};

/* define the context of a thread */
struct _lwt_context
{
    unsigned int ip, sp;
};

//typedef struct _lwt_context lwt_context;


struct list {
    struct list * next, * prev;
};


/* This structure describes a LWT thread. */
struct _lwt_t
{
    /* Linked list in a global thread queue, this struct position is fixed */
    struct list linked_list;

    /* Sender list, its position at a sender queue */
    struct list sender_queue;

    /* Thread id */
    t_id lwt_id;

    /* the status of a thread */
    t_stat status;

    /* thread regarding join */
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
struct lwt_channel
{
    /* channel ID */
    int chan_id;

    /* Linked list */
    struct list sender_queue;

    /* number of senders of this channel */
    int sender_count;
    
    /* number of threads that have reference to the channel */
    int reference_counter;

    /* receiver thread */
    struct _lwt_t * receiver;
};
typedef struct lwt_channel * lwt_chan_t;

/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);
typedef void * (*lwt_chan_fn_t)(lwt_chan_t);

/* Funciton declaration for lwt thread operation */
lwt_t  lwt_create(lwt_fn_t fn, void * data);
void * lwt_join(lwt_t  thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t  strong_thread);
lwt_t lwt_current();
int lwt_id(lwt_t  input_thread);
int lwt_info(enum lwt_info_t t);
lwt_t lwt_current();

/* Function declaration for lwt thread channel operation */
lwt_chan_t lwt_chan (int sz);
void lwt_chan_deref (lwt_chan_t c);
int lwt_snd(lwt_chan_t c, void * data);
void *lwt_rcv(lwt_chan_t c);
int lwt_snd_chan(lwt_chan_t c, lwt_chan_t sending);
lwt_chan_t lwt_rcv_chan(lwt_chan_t c);
lwt_t lwt_create_chan(lwt_chan_fn_t fn, lwt_chan_t c);

#endif
