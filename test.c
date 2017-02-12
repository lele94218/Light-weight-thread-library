#include "lwt.h"
#include <stdio.h>
#include <stdlib.h>

lwt_t t1;
lwt_t t2;
lwt_t t3;
lwt_chan_t c;
void fun1(lwt_chan_t c);
int p = 7;
void fun()
{
    printf("this is thread 1 \n");
    c = lwt_chan(0);
    lwt_t t3 = lwt_create_chan((void *)fun1,c);
    lwt_snd(c, &p);
}
void fun1(lwt_chan_t c)
{
    printf("this is thread 2 \n");
    void * result = lwt_rcv(c);
    printf("end");
}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL);
    int p=7;
//    t2 = lwt_create((void *)fun1, NULL);
    lwt_yield(t1);
    lwt_yield(t3);
    return 0;
}
