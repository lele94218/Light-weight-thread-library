/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"
#include "lwt_dispatch.h"

lwt_t * t1;
lwt_t * t2;
lwt_t * t3;
lwt_t * t4;
lwt_t * t5;

void fun1();
void fun2();
void fun3();
void fun4();
void fun5();

void fun1()
{
    printf("Fun1 starting ... \n");
    printf("Fun1 ending ... \n");
}

void fun2()
{
    printf("Fun2 starting ... \n");
    lwt_yield(NULL);
    printf("Fun2 ending ... \n");
}

void fun3()
{
    printf("Fun3 starting ... \n");
    printf("Fun3 ending ...  \n");
}

void fun4()
{
    printf("Fun4 starting ... \n");
    lwt_yield(NULL);
    printf("Fun4 ending ... \n");
}

void fun5()
{
    printf("Fun5 starting ... \n");
    lwt_yield(NULL);
    printf("Fun5 ending ... \n");
}

int main()
{
    t1 = lwt_create((void *) fun1, NULL);
    t2 = lwt_create((void *) fun2, NULL);
	lwt_join(t1);
	lwt_join(t2);
    t3 = lwt_create((void *) fun3, NULL);
	t4 = lwt_create((void *) fun4, NULL);
    //lwt_join(t1);
    printf("main finishing...\n");
}
