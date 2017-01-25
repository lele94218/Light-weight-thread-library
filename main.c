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
    printf("fun() \n");
}

void fun1()
{
    printf("fun1() \n");
}

void fun2()
{
    printf("fun2() \n");
}

int main()
{
    lwt_t * t1 = lwt_create((void *) fun, NULL);
    lwt_t * t2 = lwt_create((void *) fun1, NULL);
    lwt_yield(NULL);
    lwt_t * t3 = lwt_create((void *) fun2, NULL);
    lwt_yield(NULL);
    lwt_yield(t1);
    printf("main finishing...\n");
}
