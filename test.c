#include "lwt.h"
#include <stdio.h>
#include <stdlib.h>

lwt_t t1;
lwt_t t2;
lwt_t t3;
lwt_t t4;
lwt_t t5;
void fun1(lwt_chan_t c);
int to_send = 7;
void fun()
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
<<<<<<< HEAD
    lwt_chan_t c = lwt_chan(0);
    lwt_chan_t d = lwt_chan(0);
    lwt_t t2 = lwt_create_chan((void *)fun1,c);
//    lwt_snd(c, &to_send);
    lwt_snd_chan(c,d);
    int * result = lwt_rcv(d);
    printf("get result%d \n", * result);
=======

    lwt_chan_t c0 = lwt_chan(0);
    lwt_chan_t c1 = lwt_chan(0);
    lwt_chan_t c2 = lwt_chan(0);
    lwt_chan_t c3 = lwt_chan(0);
    lwt_chan_t c4 = lwt_chan(0);
    lwt_chan_t c5 = lwt_chan(0);
    lwt_chan_t c_itself = lwt_chan(0);
    printf ("*****now t1's own channel has %d senders.\n", c_itself->sender_count);
    lwt_t t2 = lwt_create_chan((void *)fun1,c2);
    lwt_t t3 = lwt_create_chan((void *)fun1,c3);
    lwt_t t4 = lwt_create_chan((void *)fun1,c4);
    lwt_t t5 = lwt_create_chan((void *)fun1,c5);
    printf ("*****now t1's own channel has %d senders.\n", c_itself->sender_count);
    lwt_snd_chan(c2, c_itself);
    lwt_snd_chan(c3, c_itself);
    lwt_snd_chan(c4, c_itself);
    lwt_snd_chan(c5, c_itself);
    printf ("******now t1's own channel has %d senders.\n", c_itself->sender_count);
    int received = (int) lwt_rcv(c_itself);
    printf("thread t1 has received: %d\n", received);
    received = (int) lwt_rcv(c_itself);
    printf("thread t1 has received: %d\n", received);
    received = (int) lwt_rcv(c_itself);
    printf("thread t1 has received: %d\n", received);
    received = (int) lwt_rcv(c_itself);
    printf("thread t1 has received: %d\n", received);
    lwt_chan_deref(c_itself);
>>>>>>> 8ea7170e9f3afc05579fcf12683acafa3214f782
}
void fun1(lwt_chan_t c)
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
<<<<<<< HEAD
//    int * result = lwt_rcv(c);
    lwt_chan_t e = lwt_rcv_chan(c);
    lwt_snd(e,&to_send);	
//    printf("data %d received, end\n", *result);
=======
    lwt_chan_t  using_channel = lwt_rcv_chan(c);
    lwt_snd(using_channel, (void *)lwt_id(lwt_current()));
    printf("thread %d has complete data sent to t1\n", lwt_id(lwt_current()));
    lwt_chan_deref(using_channel);
>>>>>>> 8ea7170e9f3afc05579fcf12683acafa3214f782
}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL);
    lwt_join(t1);
    printf("main function returned\n");
    return 0;
}
