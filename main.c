/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"

int * fun(int * argument);
int fun2();

lwt_t * t0;
lwt_t * t1;
lwt_t * t2;
int * fun(int * argument)
{
	printf("start executing\n");
	lwt_yield(NULL);
	printf("fun has been executed by thread %d with input arg %d\n", lwt_id(lwt_current()),*argument);
	(*argument)+=1;
	return argument;
}

int fun2()
{
	
	printf("thread %d is executing and ends\n",lwt_id(lwt_current()));
	return 5;
}

int main()
{
	int argToPass=12345;
	t0 = lwt_current();
    t1 = lwt_create((void *) fun, (void *)(&argToPass));
	lwt_yield(NULL);
	lwt_join(t1);

	t2 = lwt_create((void *) fun2, NULL);
	int argToReceive=(int)lwt_join(t2);
	printf("main thread picked up thread 2's return value %d\n",argToReceive);
    printf("main finishing, following threads still active:\n");
	print_living_thread_info();
	return 0;
}
