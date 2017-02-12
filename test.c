#include "lwt.h"
#include <stdio.h>
#include <stdlib.h>

lwt_t t1;
lwt_t t2;
lwt_t t3;
void fun1(lwt_chan_t c);
int to_send = 7;
void fun()
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
    lwt_chan_t c = lwt_chan(0);
    lwt_chan_t d = lwt_chan(0);
    lwt_t t2 = lwt_create_chan((void *)fun1,c);
//    lwt_snd(c, &to_send);
    lwt_snd_chan(c,d);
    int * result = lwt_rcv(d);
    printf("get result%d \n", * result);
}
void fun1(lwt_chan_t c)
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
//    int * result = lwt_rcv(c);
    lwt_chan_t e = lwt_rcv_chan(c);
    lwt_snd(e,&to_send);	
//    printf("data %d received, end\n", *result);
}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL);
    int p=7;
//    t2 = lwt_create((void *)fun1, NULL);
    lwt_join(t1);
    printf("main function returned\n");
    return 0;
}
