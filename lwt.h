#ifndef LWT_H
#define LWT_H

/* */
#include "lwt_dispatch.h"

#define MAX_STACK_SIZE 2097152



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

	/* previous and next thread in list */
	struct _lwt_t * next;
	struct _lwt_t * prev;

	/* thread regarding join and wait */
	struct _lwt_t * unlock;
	struct _lwt_t * waiting_for;
	
	/* initial stack pointer */
	unsigned int init_sp;

	/* return value */
	void * last_word;
    
    /* Thread context */
    lwt_context context;
}
lwt_t;

/* LinkedList definiation */
typedef struct _linked_list
{
    lwt_t *head, *tail;
    int node_count;
}
linked_list;


/* Funciton declaration */
lwt_t * lwt_create(lwt_fn_t fn, void * data);
void * lwt_join(lwt_t * thread_to_wait);
void lwt_die(void *);
int lwt_yield(lwt_t * strong_thread);
lwt_t * lwt_current();
int lwt_id(lwt_t * input_thread);
lwt_t * lwt_current();

//int lwt_info(lwt_info_t t);


/* test function declaration */
void print_living_thread_info();



#endif





