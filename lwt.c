#include <stdio.h>
#include <stdlib.h>


#include "lwt.h"
#include "lwt_dispatch.h"


/* Global variable */
int lwt_counter;
int thread_initiated = 0;
linked_list * thread_queue = NULL;
lwt_t * current_thread = NULL;

int
__add_thread_to_list (lwt_t * thread, linked_list * list)
{
    linked_list_node * node = (linked_list_node *) malloc (sizeof (linked_list_node));
    node->data = thread;
    node->next = NULL;
	node->prev = NULL;
    
    if (!list->node_count)
    {
        list->head = node;
        list->tail = node;
    }
    else
    {
        list->tail->next = node;
        node->prev = list->tail;
        list->tail = node;
    }
    
    ++ list->node_count;
    return list->node_count - 1;
}

int
__delete_thread_to_list (lwt_t * thread, linked_list * list)
{
    linked_list_node * curr = list->head;
    //linked_list_node * temp = NULL;
    while (curr)
    {
        if (thread->lwt_id == curr->data->lwt_id)
        {
            curr->prev->next = curr->next;
            curr->next->prev = curr->prev;
            free(curr);
            return 1;
        }
    }
    return 0;
}

lwt_t*
__get_next_thread (lwt_t * p_thread, linked_list * list)
{
    linked_list_node * curr = list->tail;
    // TODO scheduling
    p_thread = curr->data;
    return p_thread;
}


static void
__initiate()
{
    thread_initiated = 1;
    thread_queue = (linked_list * ) malloc (sizeof(linked_list));
    current_thread = (lwt_t * ) malloc (sizeof(lwt_t));
    __add_thread_to_list(current_thread, thread_queue);
	printf("thread main created\n");
    return;
}

lwt_t *
lwt_create(lwt_fn_t fn, void * data, lwt_t * origin_thread)
{
    if(!thread_initiated) __initiate();

	/* create next thread */
    lwt_t * created_thread = (lwt_t *) malloc(sizeof(lwt_t));
	origin_thread=current_thread;

    created_thread->context.sp = (uint) malloc(1000);
    created_thread->context.ip = (uint) fn;

	created_thread->lwt_id=++lwt_counter;
	__add_thread_to_list(created_thread, thread_queue);

    printf("create function returned\n");
	printf("original Thread is %d, created thread is %d\n", origin_thread->lwt_id,created_thread->lwt_id);

    return created_thread;
}
