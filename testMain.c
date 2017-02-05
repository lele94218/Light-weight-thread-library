/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"

lwt_t t1;
lwt_t t2;
lwt_t t3;
lwt_t t4;
lwt_t t5;

int fun3();

int fun1(int * i)
{
    printf("Fun1 starting ... \n");
    (*i)++;
    printf("Fun1 ending ... \n");
    return *i;
}

void fun2()
{
    printf("Fun2 starting ... \n");
    lwt_join(t1);
    t3=lwt_create((void *)fun3, NULL);
    printf("Fun2 ending ... \n");
}

int fun3()
{
	int a,b,c;
	a=1;b=2;c=a+b;
    printf("Fun3 starting ... \n");
    printf("Fun3 ending ...  \n");
return c;
}

void fun4()
{
    printf("Fun4 starting ... \n");
    lwt_yield(NULL);
    printf("Fun4 ending ... \n");
lwt_join(t3);
}

void fun5()
{
	int a,b,c;
	a=5;
b=6;
c=a+b;
    printf("Fun5 starting ... \n");
    lwt_yield(NULL);
    printf("Fun5 ending ... %d\n",c);
}

int main()
{   
    int * p = malloc(sizeof(int));
    *p = 5;
     
    printf("%d\n", fun1(p));
    t1 = lwt_create((void *) fun1, p);
    t2 = lwt_create((void *) fun2, NULL);
  t3 = lwt_create((void *) fun3, NULL);
	t4 = lwt_create((void *) fun4, NULL);
	t5 = lwt_create((void *) fun5, NULL);
	printf("function collected thread 5 and get return value: %d\n",(int)lwt_join(t5));
lwt_join(t4);
lwt_join(t2);
    printf("main finishing...\n");
}
