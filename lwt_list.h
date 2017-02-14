#ifndef LWT_LIST_H
#define LWT_LIST_H

/* linked list structure, for all linked list in this lib */
struct list {
    struct list * next, * prev;
};

struct list_head {
    struct list l;
}

#define LIST_DEF_NAME list

/* below two functions are universal list operation function */
static inline void
list_insert(struct list * link, struct list * new_link)
{
    new_link->prev = link->prev;
    new_link->next = link;
    new_link->prev->next = new_link;
    new_link->next->prev = new_link;
}

/* Inint list */
static inline void
list_init(struct list *list)
{
    list->next = list;
    list->prev = list;
}

/* Remove from list */
static inline void
list_remove(struct list *list)
{
    list->next->prev = list->prev;
    list->prev->next = list->next;
    list->prev = list->next = list;
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

#endif
