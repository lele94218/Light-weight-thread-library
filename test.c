#include "lwt.h"
#include <stdio.h>
#include <stdlib.h>

void print_all_info()
{
    print_queue_content(LWT_INFO_NTHD_RUNNABLE);
    print_queue_content(LWT_INFO_NTHD_BLOCKED);
    print_queue_content(LWT_INFO_NTHD_ZOMBIES);
    print_queue_content(LWT_INFO_NTHD_RECYCLE);
    print_queue_content(LWT_INFO_NCHAN);
    print_queue_content(LWT_INFO_DCHAN);
    printf("number runnable: %d.\n",lwt_info(LWT_INFO_NTHD_RUNNABLE));
    printf("number blocked: %d.\n",lwt_info(LWT_INFO_NTHD_BLOCKED));
    printf("number zombies: %d.\n",lwt_info(LWT_INFO_NTHD_ZOMBIES));
    printf("number recycle: %d.\n",lwt_info(LWT_INFO_NTHD_RECYCLE));
    printf("number blocked joining: %d.\n",lwt_info(LWT_INFO_NJOINING));
    printf("number blocked receiving: %d.\n",lwt_info(LWT_INFO_NRCVING));
    printf("number blocked sending: %d.\n",lwt_info(LWT_INFO_NSNDING));
    printf("number working channel: %d.\n",lwt_info(LWT_INFO_NCHAN));
    printf("number dead channel: %d.\n",lwt_info(LWT_INFO_DCHAN));
}

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
}
void fun1(lwt_chan_t c)
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
    lwt_chan_t  using_channel = lwt_rcv_chan(c);
    lwt_snd(using_channel, (void *)lwt_id(lwt_current()));
    printf("thread %d has complete data sent to t1\n", lwt_id(lwt_current()));
    lwt_chan_deref(using_channel);
}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL);
    lwt_join(t1);
    lwt_chan(0);
    print_all_info();
    printf("main function returned\n");
    return 0;
}
