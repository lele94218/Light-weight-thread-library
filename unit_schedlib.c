/*
 * Copyright 2016, Phani Gadepalli and Gabriel Parmer, GWU, gparmer@gwu.edu.
 *
 * This uses a two clause BSD License.
 */

#include <stdio.h>
#include <string.h>
#include <cos_component.h>
#include <cobj_format.h>
#include <cos_defkernel_api.h>

#include <sl.h>

#include <lwt.h>

#undef assert
#define assert(node) do { if (unlikely(!(node))) { debug_print("assert error in @ "); *((int *)0) = 0; } } while (0)
#define PRINT_FN prints
#define debug_print(str) (PRINT_FN(str __FILE__ ":" STR(__LINE__) ".\n"))
#define BUG() do { debug_print("BUG @ "); *((int *)0) = 0; } while (0);
#define SPIN(iters) do { if (iters > 0) { for (; iters > 0 ; iters -- ) ; } else { while (1) ; } } while (0)

#define ITER 1000
struct cos_compinfo *ci;

static void
cos_llprint(char *s, int len)
{ call_cap(PRINT_CAP_TEMP, (int)s, len, 0, 0); }

int
prints(char *s)
{
	int len = strlen(s);

	cos_llprint(s, len);

	return len;
}

int __attribute__((format(printf,1,2)))
printc(char *fmt, ...)
{
	  char s[128];
	  va_list arg_ptr;
	  int ret, len = 128;

	  va_start(arg_ptr, fmt);
	  ret = vsnprintf(s, len, fmt, arg_ptr);
	  va_end(arg_ptr);
	  cos_llprint(s, ret);

	  return ret;
}

#define N_TESTTHDS 8
#define WORKITERS  100000

void
test_thd_fn(void *data)
{
	while (1) {
		int workiters = WORKITERS * ((int)data);

		printc("%d", (int)data);
		SPIN(workiters);
		sl_thd_yield(0);
	}
}

void
test_yields(void)
{
	int                     i;
	struct sl_thd          *threads[N_TESTTHDS];
	union sched_param       sp    = {.c = {.type = SCHEDP_PRIO, .value = 10}};

	for (i = 0 ; i < N_TESTTHDS ; i++) {
		threads[i] = sl_thd_alloc(test_thd_fn, (void *)(i + 1));
		assert(threads[i]);
		sl_thd_param_set(threads[i], sp.v);
	}
}

void
test_high(void *data)
{
	struct sl_thd *t = data;

	while (1) {
		sl_thd_yield(t->thdid);
		printc("h");
	}
}

void
test_low(void *data)
{
	while (1) {
		int workiters = WORKITERS * 10;
		SPIN(workiters);
		printc("l");
	}
}

void
test_lwt(int a)
{
	while (1)
	{
		int cnt = 1000;
		SPIN(cnt);
		printc("%d", a);
	}
}

#define rdtscll(val) __asm__ __volatile__("rdtsc" \
                                          : "=A"(val))


/*
 * My output on an Intel Core i5-2520M CPU @ 2.50GHz:
 *
 * [PERF] 120 <- fork/join
 * [PERF] 13 <- yield
 * [TEST] thread creation/join/scheduling
 * [PERF] 48 <- snd+rcv (buffer size 0)
 * [TEST] multisend (channel buffer size 0)
 * [PERF] 27 <- asynchronous snd->rcv (buffer size 100)
 * [TEST] multisend (channel buffer size 100)
 * [TEST] group wait (channel buffer size 0, grpsz 3)
 * [TEST] group wait (channel buffer size 3, grpsz 3)
 */

void *
fn_bounce(void *d)
{
    int i;
    unsigned long long start, end;

    lwt_yield(LWT_NULL);
    lwt_yield(LWT_NULL);
    rdtscll(start);
    for (i = 0; i < ITER; i++)
        lwt_yield(LWT_NULL);
    rdtscll(end);
    lwt_yield(LWT_NULL);
    lwt_yield(LWT_NULL);

    if (!d)
        printc("[PERF] %5lld <- yield\n", (end - start) / (ITER * 2));

    return NULL;
}

void *
fn_null(void *d)
{
    return NULL;
}

#define IS_RESET()                                  \
    assert(lwt_info(LWT_INFO_NTHD_RUNNABLE) == 1 && \
           lwt_info(LWT_INFO_NTHD_ZOMBIES) == 0 &&  \
           lwt_info(LWT_INFO_NTHD_BLOCKED) == 0)

void test_perf(void)
{
    lwt_t chld1, chld2;
    int i;
    unsigned long long start, end;

    /* Performance tests */
    rdtscll(start);
    for (i = 0; i < ITER; i++)
    {

        printd("-------------create-------------\n");
        chld1 = lwt_create(fn_null, NULL, 0);
        printd("-------------created-------------\n");
        lwt_join(chld1);
    }
    rdtscll(end);

    printc("[PERF] %5lld <- fork/join\n", (end - start) / ITER);
    IS_RESET();

    chld1 = lwt_create(fn_bounce, (void *)1, 0);
    chld2 = lwt_create(fn_bounce, NULL, 0);
    lwt_join(chld1);
    lwt_join(chld2);
    IS_RESET();
}

void *
fn_identity(void *d)
{
    return d;
}

void *
fn_nested_joins(void *d)
{
    lwt_t chld;

    if (d)
    {
        lwt_yield(LWT_NULL);
        lwt_yield(LWT_NULL);
        assert(lwt_info(LWT_INFO_NTHD_RUNNABLE) == 1);
        lwt_die(NULL);
    }
    chld = lwt_create(fn_nested_joins, (void *)1, 0);
    lwt_join(chld);
}

volatile int sched[2] = {0, 0};
volatile int curr = 0;

void *
fn_sequence(void *d)
{
    int i, other, val = (int)d;

    for (i = 0; i < ITER; i++)
    {
        other = curr;
        curr = (curr + 1) % 2;
        sched[curr] = val;
        assert(sched[other] != val);
        lwt_yield(LWT_NULL);
    }

    return NULL;
}

void *
fn_join(void *d)
{
    lwt_t t = (lwt_t)d;
    void *r;

    r = lwt_join(d);
    printc("return value is %d \n", (int)r);
    assert(r != (void *)0x37337);
}

void test_crt_join_sched(void)
{
    lwt_t chld1, chld2;

    printc("[TEST] thread creation/join/scheduling\n");

    /* functional tests: scheduling */
    lwt_yield(LWT_NULL);

    chld1 = lwt_create(fn_sequence, (void *)1, 0);
    chld2 = lwt_create(fn_sequence, (void *)2, 0);
    lwt_join(chld2);
    lwt_join(chld1);

    IS_RESET();

    /* functional tests: join */
    chld1 = lwt_create(fn_null, NULL, 0);
    lwt_join(chld1);
    IS_RESET();

    chld1 = lwt_create(fn_null, NULL, 0);
    lwt_yield(LWT_NULL);
    lwt_join(chld1);
    IS_RESET();

    chld1 = lwt_create(fn_nested_joins, NULL, 0);
    lwt_join(chld1);
    IS_RESET();

    /* functional tests: join only from parents */
    chld1 = lwt_create(fn_identity, (void *)0x37337, 0);
    chld2 = lwt_create(fn_join, chld1, 0);
    lwt_yield(LWT_NULL);
    lwt_yield(LWT_NULL);
    lwt_join(chld2);
    lwt_join(chld1);
    IS_RESET();

    /* functional tests: passing data between threads */
    chld1 = lwt_create(fn_identity, (void *)0x37337, 0);
    assert((void *)0x37337 == lwt_join(chld1));
    IS_RESET();

    /* functional tests: directed yield */
    chld1 = lwt_create(fn_null, NULL, 0);
    lwt_yield(chld1);
    assert(lwt_info(LWT_INFO_NTHD_ZOMBIES) == 1);
    lwt_join(chld1);
    IS_RESET();
}

void *
fn_chan(lwt_chan_t to)
{
    lwt_chan_t from;
    int i;

    from = lwt_chan(0);
    lwt_snd_chan(to, from);
    assert(from->snd_cnt);
    for (i = 0; i < ITER; i++)
    {
        lwt_snd(to, (void *)1);
        assert(2 == (int)lwt_rcv(from));
    }
    lwt_chan_deref(from);

    return NULL;
}

void test_perf_channels(int chsz)
{
    lwt_chan_t from, to;
    lwt_t t;
    int i;
    unsigned long long start, end;

    //assert(LWT_RUNNING == lwt_current()->state);
    from = lwt_chan(chsz);
    assert(from);
    t = lwt_create_chan(fn_chan, from);
    to = lwt_rcv_chan(from);
    assert(to->snd_cnt);
    rdtscll(start);
    for (i = 0; i < ITER; i++)
    {
        assert(1 == (int)lwt_rcv(from));
        lwt_snd(to, (void *)2);
    }
    lwt_chan_deref(to);
    rdtscll(end);
    printc("[PERF] %5lld <- snd+rcv (buffer size %d)\n",
           (end - start) / (ITER * 2), chsz);
    lwt_join(t);
}

static int sndrcv_cnt = 0;

void *
fn_snder(lwt_chan_t c, int v)
{
    int i;

    for (i = 0; i < ITER; i++)
    {
        lwt_snd(c, (void *)v);
        sndrcv_cnt++;
    }

    return NULL;
}

void *fn_snder_1(lwt_chan_t c) { return fn_snder(c, 1); }
void *fn_snder_2(lwt_chan_t c) { return fn_snder(c, 2); }

void test_multisend(int chsz)
{
    lwt_chan_t c;
    lwt_t t1, t2;
    int i, ret[ITER * 2], sum = 0, maxcnt = 0;

    printc("[TEST] multisend (channel buffer size %d)\n", chsz);

    c = lwt_chan(chsz);
    assert(c);
    t1 = lwt_create_chan(fn_snder_2, c);
    t2 = lwt_create_chan(fn_snder_1, c);
    for (i = 0; i < ITER * 2; i++)
    {
        //if (i % 5 == 0) lwt_yield(LWT_NULL);
        ret[i] = (int)lwt_rcv(c);
        if (sndrcv_cnt > maxcnt)
            maxcnt = sndrcv_cnt;
        sndrcv_cnt--;
    }
    lwt_join(t1);
    lwt_join(t2);

    for (i = 0; i < ITER * 2; i++)
    {
        sum += ret[i];
        assert(ret[i] == 1 || ret[i] == 2);
    }
    assert(sum == (ITER * 1) + (ITER * 2));
    /*
     * This is important: Asynchronous means that the buffer
     * should really fill up here as the senders never block until
     * the buffer is full.  Thus the difference in the number of
     * sends and the number of receives should vary by the size of
     * the buffer.  If your implementation doesn't do this, it is
     * doubtful you are really doing asynchronous communication.
     */
    assert(maxcnt >= chsz);

    return;
}

static int async_sz = 0;

void *
fn_async_steam(lwt_chan_t to)
{
    int i;

    for (i = 0; i < ITER; i++)
        lwt_snd(to, (void *)(i + 1));
    lwt_chan_deref(to);

    return NULL;
}

void test_perf_async_steam(int chsz)
{

    lwt_chan_t from;
    lwt_t t;
    int i;
    unsigned long long start, end;

    async_sz = chsz;
    assert(LWT_RUNNING == lwt_current()->state);

    from = lwt_chan(chsz);
    printc("chsz size: %d---------------\n", chsz);
    assert(from);
    t = lwt_create_chan(fn_async_steam, from);
    assert(lwt_info(LWT_INFO_NTHD_RUNNABLE) == 2);
    rdtscll(start);
    for (i = 0; i < ITER; i++)
        assert(i + 1 == (int)lwt_rcv(from));
    rdtscll(end);
    printc("[PERF] %5lld <- asynchronous snd->rcv (buffer size %d)\n",
           (end - start) / (ITER * 2), chsz);
    lwt_join(t);
}

void *
fn_grpwait(lwt_chan_t c)
{
    int i;

    for (i = 0; i < ITER; i++)
    {
        if ((i % 7) == 0)
        {
            int j;

            for (j = 0; j < (i % 8); j++)
                lwt_yield(NULL);
        }
        lwt_snd(c, (void *)lwt_id(lwt_current()));
    }
}

#define GRPSZ 3

void test_grpwait(int chsz, int grpsz)
{
    lwt_chan_t cs[grpsz];
    lwt_t ts[grpsz];
    int i;
    lwt_cgrp_t g;

    printc("[TEST] group wait (channel buffer size %d, grpsz %d)\n",
           chsz, grpsz);
    g = lwt_cgrp();
    assert(g);

    for (i = 0; i < grpsz; i++)
    {
        cs[i] = lwt_chan(chsz);
        assert(cs[i]);
        ts[i] = lwt_create_chan(fn_grpwait, cs[i]);
        lwt_chan_mark_set(cs[i], (void *)lwt_id(ts[i]));
        lwt_cgrp_add(g, cs[i]);
    }
    lwt_yield(NULL);
    assert(lwt_cgrp_free(g) == -1);
    /**
     * Q: why don't we iterate through all of the data here?
     *
     * A: We need to fix 1) cevt_wait to be level triggered, or 2)
     * provide a function to detect if there is data available on
     * a channel.  Either of these would allows us to iterate on a
     * channel while there is more data pending.
     */
    // for (i = 0 ; i < ((ITER * grpsz)-(grpsz*chsz)) ; i++) {
    for (i = 0; i < ITER * grpsz; i++)
    {
        lwt_chan_t c;
        int r;

        c = lwt_cgrp_wait(g);
        assert(c);
        lwt_yield(NULL);
        r = (int)lwt_rcv(c);
        assert(r == (int)lwt_chan_mark_get(c));
    }
    for (i = 0; i < grpsz; i++)
    {
        lwt_cgrp_rem(g, cs[i]);
        lwt_join(ts[i]);
        lwt_chan_deref(cs[i]);
    }
    assert(!lwt_cgrp_free(g));

    return;
}

int test_file(void)
{
    __initiate();
    printd("--------------------------\n");
    test_perf();
    test_perf_channels(0);
    test_perf_async_steam(ITER / 10 < 100 ? ITER / 10 : 100);
    test_crt_join_sched();
    test_multisend(0);
    test_multisend(ITER / 10 < 100 ? ITER / 10 : 100);
    test_grpwait(0, 15);
    test_grpwait(15, 15);

    return 0;
}


void
test_blocking_directed_yield(void)
{
	printc("begin test...\n");
	// struct sl_thd          *low, *high;
	// union sched_param       sph = {.c = {.type = SCHEDP_PRIO, .value = 5}};
	// union sched_param       spl = {.c = {.type = SCHEDP_PRIO, .value = 10}};

	// low  = sl_thd_alloc(test_low, NULL);
	// high = sl_thd_alloc(test_high, low);
	// sl_thd_param_set(low, spl.v);
	// sl_thd_param_set(high, sph.v);
	// lwt_kthd_create(test_lwt, NULL);
	// lwt_kthd_create(test_lwt, NULL);


}

void
cos_init(void)
{
	struct cos_defcompinfo *defci = cos_defcompinfo_curr_get();
	ci = cos_compinfo_get(defci);

	printc("Unit-test for the scheduling library (sl)\n");
	cos_meminfo_init(&(ci->mi), BOOT_MEM_KM_BASE, COS_MEM_KERN_PA_SZ, BOOT_CAPTBL_SELF_UNTYPED_PT);
	cos_defcompinfo_init();
	sl_init();

	test_yields();
	test_blocking_directed_yield();
	sl_sched_loop();
    test_file();
	assert(0);

	return;
}
