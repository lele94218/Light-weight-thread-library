#include <stdio.h>
#include <stdlib.h>

#include "lwt.h"

static inline void
list_insert(struct list * link, struct list * new_link)
{
    new_link->prev = link->prev;
    new_link->next = link;
    new_link->prev->next = new_link;
    new_link->next->prev = new_link;
}

/* Insert new link after link */
static inline void
list_append(struct list *list, struct list *new_link)
{
    list_insert((struct list *)list, new_link);
}

/* Insert new link before link */
static inline void
list_prepend(struct list *list, struct list *new_link)
{
    list_insert(list->next, new_link);
}

/* Remove link form list */
static inline void
list_remove(struct list *link)
{
    link->prev->next = link->next;
    link->next->prev = link->prev;
}

static inline void
list_init(struct list *list)
{
    list->next = list;
    list->prev = list;
}


/* Global variable */
/* used for assigning thread id */
int lwt_counter = 0;
int thread_initiated = 0;

/* three queues, one for thread either waiting or running, one for zombies, one for recycle */
struct list valid_queue;
struct list block_queue;
struct list recycle_queue;
struct list zombie_queue;

/* identify threads */
lwt_t current_thread;
lwt_t old_thread;


/* internal function declaration, below functions are only used internally */
/* functions for thread operation */
inline void __lwt_dispatch(lwt_context *curr, lwt_context *next);
void __lwt_schedule (void);
lwt_t  __create_thread(int with_stack, lwt_fn_t fn, void * data);
lwt_t  __reuse_thread(lwt_fn_t fn, void * data);
void *__lwt_trampoline();
void __initiate(void);

/* thread queue functions declarartion */
void __add_to_tail(lwt_t, struct list *);
void __add_to_head(lwt_t, struct list *);
void __remove_from_queue(lwt_t);

/* add a thread to tail of a thread queue */
void
__add_to_tail (lwt_t thread, struct list * thread_queue)
{
    list_append(thread_queue, &thread->linked_list);
}

/* add a thread to head of a thread queue */
void
__add_to_head (lwt_t thread, struct list * thread_queue)
{
    list_prepend(thread_queue, &thread->linked_list);
}

/* remove a thread from a queue */
void
__remove_from_queue(lwt_t thread)
{
    list_remove(&thread->linked_list);
}

/* pause one thread, start executing the next one */
inline void
__lwt_dispatch(lwt_context *curr, lwt_context *next)
{
    __asm__ __volatile__
    (
#ifdef SAFE_MODE
     "push %%ebx;"
     "push %%esi;"
     "push %%edi;"
#endif
     "movl %%esp,%0;"
     "movl $retDispatch%=,%1;"
     "movl %2,%%esp;"
     "jmp *%3;"
     "retDispatch%=:;"
#ifdef SAFE_MODE
     "pop %%edi;"
     "pop %%esi;"
     "pop %%ebx;"
#endif
     :"=m" (curr->sp),"=m" (curr->ip)
     :"m"(next->sp),"m" (next->ip)
     :
     );
}

/* find one proper thread to execute from pool */
void
__lwt_schedule ()
{
    old_thread=current_thread;
    current_thread = (lwt_t)(valid_queue.next);
    if (current_thread&&current_thread!=old_thread)
    {
#ifdef DEBUG_MODE
        printf("thread %d start executing from reschedule\n", current_thread->lwt_id);
#endif
        __lwt_dispatch(&old_thread->context, &current_thread->context);
        return;
    }
    else
    {
        current_thread=old_thread;
#ifdef DEBUG_MODE
        printf("thread %d cannot find a valid thread to dispatch, keep executing\n",current_thread->lwt_id);
#endif
        return;
    }
}

/* create and initialize a thread */
lwt_t
__create_thread(int with_stack, lwt_fn_t fn, void * data)
{
    lwt_t  created_thread=(lwt_t) malloc (sizeof(struct _lwt_t));
    created_thread->lwt_id = lwt_counter ++;
    created_thread->status = LWT_INFO_NTHD_RUNNABLE;
    created_thread->next = NULL;
    created_thread->prev = NULL;
    created_thread->merge_to = NULL;
    created_thread->wait_merge = NULL;
    created_thread->last_word = NULL;
    /* create a stack for the thread */
    if (with_stack)
    {
        /* init stack with die function */
        uint _sp = (uint) malloc(MAX_STACK_SIZE);
        created_thread->init_sp = _sp;
        _sp += (MAX_STACK_SIZE - sizeof(uint));
        *((uint *)_sp) = (uint)data;
        _sp -= (sizeof(uint));
        *((uint *)_sp) = (uint)fn;
        _sp -= (sizeof(uint));
        created_thread->context.sp = _sp;
        created_thread->context.ip = (uint) __lwt_trampoline;
    }
#ifdef DEBUG_MODE
    printf("create thread %d complete\n", created_thread->lwt_id);
#endif
    return created_thread;
}

/* reuse a thread from recycle_queue instead of create */
lwt_t
__reuse_thread(lwt_fn_t fn, void * data)
{
    lwt_t reused_thread = (lwt_t)(recycle_queue.next);
    __remove_from_queue(reused_thread);
    reused_thread->lwt_id = lwt_counter ++;
    reused_thread->status = LWT_INFO_NTHD_RUNNABLE;
    reused_thread->next = NULL;
    reused_thread->prev = NULL;
    reused_thread->merge_to = NULL;
    reused_thread->wait_merge = NULL;
    reused_thread->last_word = NULL;
#ifdef DEBUG_MODE
    printf("create thread %d from recycle\n", reused_thread->lwt_id);
#endif
    uint _sp=reused_thread->init_sp;
    _sp += (MAX_STACK_SIZE - sizeof(uint));
    *((uint *)_sp) = (uint)data;
    _sp -= (sizeof(uint));
    *((uint *)_sp) = (uint)fn;
    _sp -= (sizeof(uint));
    reused_thread->context.sp = _sp;
    reused_thread->context.ip = (uint) __lwt_trampoline;
    return reused_thread;
}

/* initialize main thread and the queues when user called create at first time */
void
__initiate()
{
    thread_initiated = 1;
    current_thread = __create_thread(0, (void *)NULL, NULL);
    /* initialize valid_queue */
    list_init(&valid_queue);
    
    /* initialize block_queue */
    list_init(&block_queue);
    
    /* initialize recycle queue */
    list_init(&recycle_queue);
    
    /* initialize zombie_queue */
    list_init(&zombie_queue);
    
    __add_to_tail(current_thread, &valid_queue);
#ifdef DEBUG_MODE
    printf("initialization complete\n");
#endif
}


/* create a thread, return its lwt_t pointer */
lwt_t
lwt_create(lwt_fn_t fn, void * data)
{
    if(!thread_initiated) __initiate();
    lwt_t  next_thread;
    /* decide if re-use from recycle queue */
    next_thread = (recycle_queue.next != recycle_queue.prev) ? __reuse_thread(fn, data) : __create_thread(1, fn, data);
#ifdef DEBUG_MODE
    printf("thread: %d has created thread: %d\n", current_thread->lwt_id,next_thread->lwt_id);
#endif
    __add_to_tail(next_thread, &valid_queue);
    return next_thread;
}

/* kill a thread, either move it to zombie queue or recycle queue */
void
lwt_die(void * message)
{
#ifdef DEBUG_MODE
    printf("die function start executing for thread %d.\n",current_thread->lwt_id);
#endif
    current_thread->last_word=message;
    /* if someone is waiting to join this one, return and go to recycle queue */
    if (current_thread->merge_to)
    {
        current_thread->merge_to->status = LWT_INFO_NTHD_RUNNABLE;
        current_thread->merge_to->last_word = message;
        
        /* move block queue back to valid queue */
        __remove_from_queue(current_thread->merge_to);
        __add_to_tail(current_thread->merge_to, &valid_queue);
        
        
        current_thread->merge_to = NULL;
        current_thread->status = LWT_INFO_NTHD_ZOMBIES;
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &recycle_queue);
#ifdef DEBUG_MODE
        printf("removed dead thread %d to recycle queue\n", current_thread->lwt_id);
#endif
    }
    /* nobody is currently waiting to join this one, becomes a zombie */
    else
    {
        current_thread->status = LWT_INFO_NTHD_ZOMBIES;
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &zombie_queue);
#ifdef DEBUG_MODE
        printf("removed dead thread %d to zombie queue\n", current_thread->lwt_id);
#endif
    }
    
    /* go die, pass flow to another thread */
    __lwt_schedule();
}

/* start a thread, execute its function, get return value and ready to kill the thread */
void *
__lwt_trampoline(lwt_fn_t fn, void * data)
{
    void * return_message = fn(data);
#ifdef DEBUG_MODE
    printf("thread %d ready to die, with last word %d\n", current_thread->lwt_id,(int)return_message);
#endif
    lwt_die(return_message);
    return NULL;
}

/* put the thread to run queue end, allow others to execute, if argument has a value, yield to a specific thread */
int
lwt_yield(lwt_t strong_thread)
{
    /* yield to NULL */
    if (!strong_thread)
    {
#ifdef DEBUG_MODE
        printf("thread %d has yielded\n", current_thread->lwt_id);
#endif
        __remove_from_queue(current_thread);
        __add_to_tail(current_thread, &valid_queue);
        __lwt_schedule();
        return 0;
    }
#ifdef SAFE_MODE
    /* yield to itself */
    if (strong_thread == current_thread)
    {
#ifdef DEBUG_MODE
        printf("thread %d is yielding to itself...\n",current_thread->lwt_id);
#endif
        return 0;
    }
    /* yield to something not runnable */
    if (strong_thread->status != LWT_INFO_NTHD_RUNNABLE)
    {
#ifdef DEBUG_MODE
        printf("thread %d is yielding to a thread not runnable...\n",current_thread->lwt_id);
#endif
        return 0;
    }
#endif
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &valid_queue);
    __remove_from_queue(strong_thread);
    __add_to_head(strong_thread, &valid_queue);
    __lwt_schedule();
    return 0;
}

/* blocked and wait for the argument thread, when argument thread ends, resume execution and return message from the dead thread */
void *
lwt_join(lwt_t thread_to_wait)
{
#ifdef SAFE_MODE
    if(thread_to_wait == NULL)
    {
#ifdef DEBUG_MODE
        printf("error: current thread is waiting for a thread does not exists");
#endif
        return NULL;
    }
    else if(thread_to_wait == current_thread)
    {
#ifdef DEBUG_MODE
        printf("error: a thread cannot join itself");
#endif
        return NULL;
    }
    else if(thread_to_wait->merge_to != NULL)
    {
#ifdef DEBUG_MODE
        printf("error: cannot join a thread that is been reserved by others");
#endif
        return NULL;
    }
#endif
    if(thread_to_wait->status == LWT_INFO_NTHD_ZOMBIES)
    {
#ifdef DEBUG_MODE
        printf("current thread is collecting a zombie thread\n");
#endif
        __remove_from_queue(thread_to_wait);
        __add_to_tail(thread_to_wait, &recycle_queue);
        return thread_to_wait->last_word;
    }
    /* update both thread */
    current_thread->wait_merge = thread_to_wait;
    thread_to_wait->merge_to = current_thread;
#ifdef DEBUG_MODE
    printf("thread %d blocked, waiting for thread %d to join\n", current_thread->lwt_id, thread_to_wait->lwt_id);
#endif
    
    
    /* Move to blocked queue */
    
    current_thread->status = LWT_INFO_NTHD_BLOCKED;
    
    
    __remove_from_queue(current_thread);
    __add_to_tail(current_thread, &block_queue);
    
    /* */
    
    
    __lwt_schedule();
#ifdef DEBUG_MODE
    printf("thread %d picked up dead threads %d's last word %d\n", current_thread->lwt_id, current_thread->wait_merge->lwt_id, (int)current_thread->last_word);
#endif
    current_thread->wait_merge = NULL;
    return current_thread->last_word;
}

/* return current active thread */
lwt_t
lwt_current()
{
    if(!thread_initiated) __initiate();
    return current_thread;
}

/* return the id of a thread */
int
lwt_id(lwt_t input_thread)
{
    return current_thread->lwt_id;
}

int
lwt_info(lwt_info_t t)
{
    int cnt = 0;
    struct list * current;
    
    if (t == LWT_INFO_NTHD_ZOMBIES)
    {
        current = zombie_queue.next;
        while (current != &zombie_queue)
        {
            if (((lwt_t) current)->status == t) cnt ++;
            current = current->next;
        }
        
    }
    else
    {
        current = valid_queue.next;
        while (current != &valid_queue)
        {
            if (((lwt_t) current)->status == t) cnt ++;
            current = current->next;
        }
    }
    return cnt;
    
}

void
print_thread()
{
    struct list * queue = &valid_queue;
    struct list * cur = queue->next;
    while (cur != queue)
    {
        printf("%d\n", ((lwt_t)cur)->lwt_id);
        cur = cur->next;
    }
}
