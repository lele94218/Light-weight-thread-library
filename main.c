/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"

void fun();
lwt_t * t1;
lwt_t main_thread;


int main()
{
	printf("main process is executing!\n");
    t1 = lwt_create((void *) fun, NULL, &main_thread);

	__lwt_dispatch(&main_thread.context, &t1->context);
	printf("flow changed from child to main and main function completed, %d\n", 4);
    return 0;
}

void fun()
{
	printf("child thread is executing \n");
	__lwt_dispatch(&t1->context, &main_thread.context);
	printf("this should not be executed \n");
	return;
}

void max(int a, int b)
{
	return;
}
