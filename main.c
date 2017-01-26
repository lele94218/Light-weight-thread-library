/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"
#include "lwt_dispatch.h"

int fun(int argument);
int fun2();

lwt_t * t0;
lwt_t * t1;
lwt_t * t2;
int fun(int argument)
{
	lwt_yield(NULL);
	printf("fun has been executed by thread %d with input arg %d\n", lwt_id(lwt_current()),argument);
	argument+=1;
	return argument;
}

int fun2()
{
	int t1_last_word=(int)lwt_join(t1);
	printf("thread %d woke up, get the last word %d from its waker\n",lwt_id(lwt_current()),t1_last_word);
}

int main()
{
    t1 = lwt_create((void *) fun, (void *)12345);
	t0 = lwt_current();
	t2 = lwt_create((void *) fun2, NULL);
    int t1_last_word=(int)lwt_join(t1);
	printf("main thread woke up, get the last word %d from its waker\n",t1_last_word);
	t1 = lwt_create((void *) fun, (void *)12345);
    printf("main finishing, following threads still active:\n");
	print_living_thread_info();
	return 0;
}
