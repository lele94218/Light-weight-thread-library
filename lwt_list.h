#ifndef LWT_LIST_H
#define LWT_LIST_H

/* linked list structure, for all linked list in this lib */
struct list {
    struct list * n, * p;
};

struct list_head {
    struct list l;
};
#define LIST_DEF_NAME list_node

/* below two functions are universal list operation function */
static inline void
list_ll_add(struct list * link, struct list * new_link)
{
    new_link->p = link->p;
    new_link->n = link;
    new_link->p->n = new_link;
    new_link->n->p = new_link;
}

/* Init list */
static inline void
list_ll_init(struct list *list)
{
    list->n = list;
    list->p = list;
}

/* Init list head */
static inline void
list_head_init(struct list_head * lh)
{
    list_ll_init(&lh->l);
}

/* Remove from list */
static inline void
list_ll_rem(struct list *list)
{
    list->n->p = list->p;
    list->p->n = list->n;
    list->p = list->n = list;
}

/* Is list empty */
static inline int
list_ll_empty(struct list *list)
{
    return list->n == list;
}

static inline int
list_head_empty(struct list_head * lh)
{
    return list_ll_empty(&lh->l);
}

#define offsetof(type, field) \
    __builtin_offsetof(type, field)

#define container(intern, type, field) \
    ((type *)((char *)(intern) - offsetof(type, field)))

#define list_obj_get(l, o, lname) \
    container(l, __typeof__(*(o)), lname)

/* functions for if we don't use the default name for the list field */
#define list_singleton(o, lname)        list_ll_empty(&(o)->lname)
#define list_init(o, lname)             list_ll_init(&(o)->lname)
#define list_next(o, lname)             list_obj_get((o)->lname.n, (o), lname)
#define list_prev(o, lname)             list_obj_get((o)->lname.p, (o), lname)
#define list_add(o, n, lname)           list_ll_add(&(o)->lname, &(n)->lname)
#define list_append(o, n, lname)        list_add(list_prev((o), lname), n, lname)
#define list_rem(o, lname)              list_ll_rem(&(o)->lname)
#define list_head_add(lh, o, lname)     list_ll_add((&(lh)->l), &(o)->lname)
#define list_head_append(lh, o, lname)  list_ll_add(((&(lh)->l)->p), &(o)->lname)

/**
 * Explicit type API: Pass in the types of the nodes in the list, and
 * the name of the list field in that type.
 */

#define list_head_first(lh, type, lname) \
    container(((lh)->l.n), type, lname)
#define list_head_last(lh, type, lname) \
    container(((lh)->l.p), type, lname)

/* If your struct named the list field "list" (as defined by LIST_DEF_NAME */
#define list_is_head_d(lh, o)           list_is_head(lh, o, LIST_DEF_NAME)
#define list_singleton_d(o)             list_singleton(o, LIST_DEF_NAME)
#define list_init_d(o)                  list_init(o, LIST_DEF_NAME)
#define list_next_d(o)                  list_next(o, LIST_DEF_NAME)
#define list_prev_d(o)                  list_prev(o, LIST_DEF_NAME)
#define list_add_d(o, n)                list_add(o, n, LIST_DEF_NAME)
#define list_append_d(o, n)             list_append(o, n, LIST_DEF_NAME)
#define list_rem_d(o)                   list_rem(o, LIST_DEF_NAME)

#define list_head_last_d(lh, o)         list_head_last(lh, o, LIST_DEF_NAME)
#define list_head_first_d(lh, type)     list_head_first(lh, type, LIST_DEF_NAME)
#define list_head_add_d(lh, o)          list_head_add(lh, o, LIST_DEF_NAME)
#define list_head_append_d(lh, o)       list_head_append(lh, o, LIST_DEF_NAME)

/**
 * Iteration API
 */

/* Iteration without mutating the list */
#define ps_list_foreach(head, iter, lname)              \
    for (iter = ps_list_head_first((head), __typeof__(*iter), lname); \
         !ps_list_is_head((head), iter, lname);         \
         (iter) = ps_list_next(iter, lname))

#define ps_list_foreach_d(head, iter) ps_list_foreach(head, iter, PS_LIST_DEF_NAME)

#endif
