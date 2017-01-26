/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"
#include "lwt_dispatch.h"

lwt_t * t1;
lwt_t * t2;
lwt_t * t3;

int fun1(int i);
void fun2();
void fun3();
void fun4();
void fun5();

int fun1(int i)
{
    printf("Fun1 starting ... \n");
    i++;
    printf("Fun1 ending ... \n");
    return i;
}

void fun2()
{
    printf("Fun2 starting ... \n");
    lwt_yield(NULL);
//    lwt_join(t1);
    printf("Fun2 ending ... \n");
}

void fun3()
{
    printf("Fun3 starting ... \n");
    int i=lwt_join(t2);
//    lwt_yield(NULL);
    printf("Fun3 ending ... %d \n", i);
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
    int j=5;
    int *p=j;
    t1 = lwt_create((void *) fun1, p);
//    lwt_yield(NULL);
    t2 = lwt_create((void *) fun2, NULL);
//    lwt_yield(NULL);
    t3 = lwt_create((void *) fun3, NULL);
//    lwt_yield(NULL);
    lwt_t * t4 = lwt_create((void *) fun4, NULL);
    lwt_t * t5 = lwt_create((void *) fun5, NULL);
    
    lwt_yield(t1);
    lwt_yield(t2);
    lwt_yield(t3);
//    lwt_yield(t5);
    lwt_yield(NULL);
    printf("main finishing...\n");
}
