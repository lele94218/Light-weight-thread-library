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

/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);

/* User info argument type.  */
typedef enum _lwt_info_t
{
    /* The thread is running. */
    LWT_INFO_NTHD_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_INFO_NTHD_BLOCKED,
    /* This is a zombie thread. */
    LWT_INFO_NTHD_ZOMBIES
}
lwt_info_t;

typedef enum _lwt_status
{
    /* The thread is running. */
    LWT_STATUS_RUNNABLE = 0,
    /* The thread is blocked. */
    LWT_STATUS_BLOCKED,
    /* This is a zombie thread. */
    LWT_STATUS_ZOMBIES
}
lwt_status;

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
    /* Linked list */
    struct list linked_list;
    
    /* Thread id */
    t_id lwt_id;
    
    /* the status of a thread */
    t_stat status;
    
    /* thread regarding join */
    struct _lwt_t * merge_to;
    
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
    /* Linked list */
    struct list sender_queue;

    /* number of senders of this channel */
    int sender_count;

    /* receiver thread */
    struct _lwt_t * receiver;
};
typedef struct lwt_channel * lwt_chan_t;


/* Funciton declaration for lwt thread operation */
lwt_t  lwt_create(lwt_fn_t fn, void * data);
void * lwt_join(lwt_t  thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t  strong_thread);
lwt_t lwt_current();
int lwt_id(lwt_t  input_thread);
int lwt_info(lwt_info_t t);

/* Function declaration for lwt thread channel operation */
lwt_chan_t lwt_chan (int sz);
void lwt_chan_deref (lwt_chan_t c);
int lwt_snd(lwt_chan_t c, void * data);





#endif
