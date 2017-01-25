/* standard include */
#include <stdio.h>
#include <stdlib.h>

/* user lib include */
#include "lwt.h"
#include "lwt_dispatch.h"

void fun();
lwt_t main_thread;
lwt_t * t1=NULL;

int main()
{
	printf("main process is executing!\n");
    t1 = lwt_create((void *) fun, NULL, &main_thread);

	//printf("original Thread is %d, created thread is %d\n", (int)main_thread.context.sp,t1->lwt_id);
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
