#ifndef LWT_H
#define LWT_H


/* turn this on will enable error check for user input */
#define SAFE_MODE

#ifdef DEBUG
#define printd(format, ...) printf("Line: %05d: "format"\n", __LINE__, ##__VA_ARGS__)
#else
#define printd(format, ...)
#endif


/* define size of stack for created thread */
#define MAX_STACK_SIZE 2097152

/* define NULL pointer */
#define LWT_NULL NULL

/* Data type redefinition */
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;
typedef int t_id;

/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);

/* Thread state.  */
typedef enum _lwt_info_t
{
    /* The thread is running. */
    LWT_INFO_NTHD_RUNNABLE,
    /* The thread is blocked. */
    LWT_INFO_NTHD_BLOCKED,
    /* This is a zombie thread. */
    LWT_INFO_NTHD_ZOMBIES
}
lwt_info_t;

/* define the context of a thread */
typedef struct _lwt_context
{
    unsigned int ip, sp;
}
lwt_context;


struct list {
    struct list * next, * prev;
};


/* This structure describes a LWT thread. */
typedef struct _lwt_t
{
    /* Linked list */
    struct list linked_list;
    
    /* Thread id */
    t_id lwt_id;
    
    /* the status of a thread */
    lwt_info_t status;
    
    /* previous and next thread in list */
    struct _lwt_t * next;
    struct _lwt_t * prev;
    
    /* thread regarding join and wait */
    struct _lwt_t * merge_to;
    struct _lwt_t * wait_merge;
    
    /* initial stack memory pointer, lowest address */
    unsigned int init_sp;
    
    /* return value */
    void * last_word;
    
    /* Thread context */
    lwt_context context;
}
*lwt_t;

/* LinkedList definiation */
typedef struct _linked_list
{
    lwt_t head, tail;
    int node_count;
}
linked_list;


/* Funciton declaration */
lwt_t  lwt_create(lwt_fn_t fn, void * data);
void __lwt_dispatch(lwt_context *curr, lwt_context *next);
void * lwt_join(lwt_t  thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t  strong_thread);
lwt_t lwt_current();
int lwt_id(lwt_t  input_thread);
int lwt_info(lwt_info_t t);

/* test function declaration */
void print_thread();


#endif
