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

void fun1(lwt_chan_t c);
int to_send = 7;
void fun()
{
    printf("this is thread %d \n",lwt_id(lwt_current()));

    lwt_chan_t c0 = lwt_chan(4);

    lwt_chan_t c_itself = lwt_chan(4);
    lwt_chan_t c_itself2 = lwt_chan(4);
    lwt_chan_t c_itself3 = lwt_chan(4);
  
    t2 = lwt_create_chan((void *)fun1,c0);

    lwt_snd_chan(c0, c_itself);
    lwt_snd_chan(c0, c_itself2);
    lwt_snd_chan(c0, c_itself3);

    lwt_cgrp_t cgrp1 = lwt_cgrp();
    lwt_cgrp_add(cgrp1, c_itself);
    lwt_cgrp_add(cgrp1, c_itself2);
    lwt_cgrp_add(cgrp1, c_itself3);
    lwt_chan_t chan = lwt_cgrp_wait(cgrp1);
    int received = (int) lwt_rcv(chan);
    printf("thread t1 has received: %d\n", received);
    lwt_chan_t chan2 = lwt_cgrp_wait(cgrp1);
    received = (int) lwt_rcv(chan2);
    printf("thread t1 has received: %d\n", received);

}
void fun1(lwt_chan_t c)
{
    printf("this is thread %d \n",lwt_id(lwt_current()));
    lwt_chan_t using_channel = lwt_rcv_chan(c);
    lwt_chan_t using_channel2 = lwt_rcv_chan(c);
    lwt_chan_t using_channel3 = lwt_rcv_chan(c);
   
    lwt_snd(using_channel, (void *)3);
    lwt_snd(using_channel2, (void *)4);

    printf("thread %d has complete data sent to t1\n", lwt_id(lwt_current()));

}
int main(int argc, char *argv[])
{
    t1 = lwt_create((void *)fun, NULL, 0);
    lwt_yield(t1);
    lwt_yield(NULL);
    lwt_yield(NULL);
//    lwt_chan(0);
//    print_all_info();
    lwt_t t3 = lwt_create((void *)fun, NULL, LWT_NOJOIN);
    lwt_join(t3);
    printf("main function returned\n");
    return 0;
}
