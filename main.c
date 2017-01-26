/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"
#include "lwt_dispatch.h"

void fun();
void fun1();
void fun2();

void fun()
{
    printf("fun() start executing\n");
    printf("fun() \n");
    lwt_yield(NULL);
    lwt_yield(NULL);
    lwt_yield(NULL);
    printf("fun() stop executing\n");
}

void fun1()
{
    printf("fun1() start executing\n");
	lwt_t * current_executing=lwt_current();
    printf("currently thread %d is running\n", lwt_id(current_executing));
	lwt_yield(NULL);
    lwt_yield(NULL);
    lwt_yield(NULL);
    lwt_yield(NULL);
    printf("fun1() stop executing\n");
}

void fun2()
{
    printf("fun2() \n");
	lwt_t * t1 = lwt_create((void *) fun1, NULL);
    lwt_yield(NULL);
    lwt_yield(NULL);
    lwt_yield(NULL);
    printf("fun2() stop executing\n");
}

int main()
{
    lwt_t * t1 = lwt_create((void *) fun, NULL);
    lwt_t * t2 = lwt_create((void *) fun1, NULL);

    lwt_t * t3 = lwt_create((void *) fun2, NULL);
	lwt_join(t1);
	lwt_join(t2);
	lwt_join(t3);
	t1 = lwt_create((void *) fun, NULL);
	lwt_yield(t1);
	lwt_yield(t1);
	lwt_yield(t1);
    printf("main finishing, following threads still active:\n");
	print_living_thread_info();
	return 0;
}
