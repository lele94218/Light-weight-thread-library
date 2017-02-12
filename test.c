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
    lwt_snd(c, &to_send);
}
void fun1(lwt_chan_t c)
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
    //void * result = lwt_rcv(c);
    printf("end\n");
}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL);
    int p=7;
//    t2 = lwt_create((void *)fun1, NULL);
    lwt_join(t1);
    return 0;
}
