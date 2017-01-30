#ifndef LWT_H
#define LWT_H

/* */
#include "lwt_dispatch.h"

#define MAX_STACK_SIZE (100 * 1024 * 4)



/* Data redefinition */
typedef unsigned int uint;
typedef unsigned short ushort;
typedef unsigned char uchar;


/* Thread id */
typedef int t_id;


/* define a function pointer */
typedef void * (*lwt_fn_t)(void *);


/* Thread state.  */
typedef enum _lwt_info_t
{
    /* The thread is running. */
    LWT_INFO_NTHD_RUNNABLE= 0,
    /* The thread is blocked. */
    LWT_INFO_NTHD_BLOCKED,
    /* This is a zombie thread. */
    LWT_INFO_NTHD_ZOMBIES
}
lwt_info_t;

/* This structure describes a LWT thread. */
typedef struct _lwt_t
{
    /* Thread id */
    t_id lwt_id;
    
    lwt_info_t status;
    
    /* Thread context */
    lwt_context context;
    
    /* Thread regarding join */
    struct _lwt_t * parent;
    struct _lwt_t * waiting_for;
    
    /* Return value */
    void * last_word;
    
    struct _lwt_t * prev;
    struct _lwt_t * next;
    
    unsigned int init_sp;
}
lwt_t;


/* LinkedList definiation */
typedef struct _linked_list
{
    lwt_t * head, * tail;
    int node_count;
}
linked_list;


/* Funciton declaration */
lwt_t * lwt_create(lwt_fn_t fn, void * data);
//void * lwt_join(lwt_t);
void lwt_die(void *);
//int lwt_yield(lwt_t);
//lwt_t lwt_current(void);
//int lwt_id(lwt_t);
//int lwt_info(lwt_info_t t);



extern lwt_context schedule_context;
extern linked_list thread_queue;
extern lwt_t * current_thread;


#endif



