	.file	"main.c"
	.text
.Ltext0:
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.section	.text.unlikely
.Ltext_cold0:
	.text
	.globl	fn_null
	.type	fn_null, @function
fn_null:
.LFB39:
	.file 1 "main.c"
	.loc 1 40 0
	.cfi_startproc
.LVL0:
	.loc 1 40 0
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE39:
	.size	fn_null, .-fn_null
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	fn_identity
	.type	fn_identity, @function
fn_identity:
.LFB41:
	.loc 1 74 0
	.cfi_startproc
.LVL1:
	.loc 1 74 0
	movl	4(%esp), %eax
	ret
	.cfi_endproc
.LFE41:
	.size	fn_identity, .-fn_identity
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.globl	__udivdi3
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"[PERF] %5lld <- yield\n"
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	fn_bounce
	.type	fn_bounce, @function
fn_bounce:
.LFB38:
	.loc 1 21 0
	.cfi_startproc
.LVL2:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	subl	$32, %esp
	.cfi_def_cfa_offset 44
	.loc 1 25 0
	pushl	$0
	.cfi_def_cfa_offset 48
	call	lwt_yield
.LVL3:
	.loc 1 26 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL4:
	.loc 1 27 0
#APP
# 27 "main.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movl	$10000, %esi
	movl	%eax, 24(%esp)
	movl	%edx, 28(%esp)
.LVL5:
	addl	$16, %esp
	.cfi_def_cfa_offset 32
.LVL6:
	.p2align 4,,10
	.p2align 3
.L4:
	.loc 1 28 0 discriminator 3
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$0
	.cfi_def_cfa_offset 48
	call	lwt_yield
.LVL7:
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	jne	.L4
	.loc 1 29 0
#APP
# 29 "main.c" 1
	rdtsc
# 0 "" 2
	.loc 1 30 0
#NO_APP
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	.loc 1 29 0
	movl	%edx, %edi
	movl	%eax, %esi
.LVL8:
	.loc 1 30 0
	pushl	$0
	.cfi_def_cfa_offset 48
	call	lwt_yield
.LVL9:
	.loc 1 31 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL10:
	.loc 1 33 0
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %eax
	testl	%eax, %eax
	je	.L9
	.loc 1 36 0
	addl	$20, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	xorl	%eax, %eax
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
.LVL11:
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL12:
.L9:
	.cfi_restore_state
.LBB8:
.LBB9:
	.file 2 "/usr/include/i386-linux-gnu/bits/stdio2.h"
	.loc 2 104 0 discriminator 1
	subl	8(%esp), %esi
.LVL13:
	sbbl	12(%esp), %edi
	pushl	$0
	.cfi_def_cfa_offset 36
	pushl	$20000
	.cfi_def_cfa_offset 40
	pushl	%edi
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	__udivdi3
.LVL14:
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	%eax
	.cfi_def_cfa_offset 40
	pushl	$.LC2
	.cfi_def_cfa_offset 44
	pushl	$1
	.cfi_def_cfa_offset 48
	call	__printf_chk
.LVL15:
	addl	$16, %esp
	.cfi_def_cfa_offset 32
.LBE9:
.LBE8:
	.loc 1 36 0 discriminator 1
	xorl	%eax, %eax
	addl	$20, %esp
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE38:
	.size	fn_bounce, .-fn_bounce
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.rodata.str1.1
.LC4:
	.string	"main.c"
.LC5:
	.string	"sched[other] != val"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	fn_sequence
	.type	fn_sequence, @function
fn_sequence:
.LFB43:
	.loc 1 96 0
	.cfi_startproc
.LVL16:
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	.loc 1 97 0
	movl	$10000, %ebx
	.loc 1 96 0
	subl	$4, %esp
	.cfi_def_cfa_offset 16
	.loc 1 96 0
	movl	16(%esp), %esi
.LVL17:
	.p2align 4,,10
	.p2align 3
.L12:
	.loc 1 100 0
	movl	curr, %edx
.LVL18:
	.loc 1 101 0
	movl	curr, %eax
	addl	$1, %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%ecx, %eax
	andl	$1, %eax
	subl	%ecx, %eax
	movl	%eax, curr
	.loc 1 102 0
	movl	curr, %eax
	movl	%esi, sched(,%eax,4)
	.loc 1 103 0
	movl	sched(,%edx,4), %eax
	cmpl	%eax, %esi
	je	.L15
	.loc 1 104 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	lwt_yield
.LVL19:
	.loc 1 99 0 discriminator 2
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	subl	$1, %ebx
	jne	.L12
	.loc 1 108 0
	addl	$4, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	xorl	%eax, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
.LVL20:
	ret
.LVL21:
.L15:
	.cfi_restore_state
.LBB12:
.LBB13:
	.loc 1 103 0
	pushl	$__PRETTY_FUNCTION__.2875
	.cfi_def_cfa_offset 20
	pushl	$103
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL22:
.LBE13:
.LBE12:
	.cfi_endproc
.LFE43:
	.size	fn_sequence, .-fn_sequence
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.1
.LC7:
	.string	"r == (void*)0x37337"
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.globl	fn_join
	.type	fn_join, @function
fn_join:
.LFB44:
	.loc 1 112 0
	.cfi_startproc
.LVL23:
	subl	$24, %esp
	.cfi_def_cfa_offset 28
.LVL24:
	.loc 1 116 0
	pushl	28(%esp)
	.cfi_def_cfa_offset 32
	call	lwt_join
.LVL25:
	.loc 1 117 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$226103, %eax
	jne	.L19
.LVL26:
	.loc 1 118 0
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
.LVL27:
.L19:
	.cfi_restore_state
.LBB16:
.LBB17:
	.loc 1 117 0
	pushl	$__PRETTY_FUNCTION__.2884
	.cfi_def_cfa_offset 20
	pushl	$117
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC7
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL28:
.LBE17:
.LBE16:
	.cfi_endproc
.LFE44:
	.size	fn_join, .-fn_join
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC9:
	.string	"lwt_info(LWT_INFO_NTHD_RUNNABLE) == 1"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	fn_nested_joins
	.type	fn_nested_joins, @function
fn_nested_joins:
.LFB42:
	.loc 1 78 0
	.cfi_startproc
.LVL29:
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	.loc 1 81 0
	movl	16(%esp), %eax
	testl	%eax, %eax
	je	.L21
	.loc 1 82 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	lwt_yield
.LVL30:
	.loc 1 83 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL31:
	.loc 1 84 0
	movl	$0, (%esp)
	call	lwt_info
.LVL32:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L27
	.loc 1 85 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	lwt_die
.LVL33:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L21:
	.loc 1 87 0
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$fn_nested_joins
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL34:
	.loc 1 88 0
	movl	%eax, 32(%esp)
	.loc 1 89 0
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	.loc 1 88 0
	jmp	lwt_join
.LVL35:
.L27:
	.cfi_def_cfa_offset 16
.LBB20:
.LBB21:
	.loc 1 84 0
	pushl	$__PRETTY_FUNCTION__.2866
	.cfi_def_cfa_offset 20
	pushl	$84
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC9
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL36:
.LBE21:
.LBE20:
	.cfi_endproc
.LFE42:
	.size	fn_nested_joins, .-fn_nested_joins
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.str1.1
.LC11:
	.string	"[PERF] %5lld <- fork/join\n"
	.section	.rodata.str1.4
	.align 4
.LC12:
	.string	"lwt_info(LWT_INFO_NTHD_RUNNABLE) == 1 && lwt_info(LWT_INFO_NTHD_ZOMBIES) == 0 && lwt_info(LWT_INFO_NTHD_BLOCKED) == 0"
	.section	.text.unlikely
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	test_perf
	.type	test_perf, @function
test_perf:
.LFB40:
	.loc 1 49 0
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 56 0
#APP
# 56 "main.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movl	$10000, %ebx
	movl	%eax, %esi
	movl	%edx, %edi
.LVL37:
	.p2align 4,,10
	.p2align 3
.L29:
	.loc 1 58 0 discriminator 3
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_null
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL38:
	.loc 1 59 0 discriminator 3
	movl	%eax, (%esp)
	call	lwt_join
.LVL39:
	.loc 1 57 0 discriminator 3
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	subl	$1, %ebx
	jne	.L29
	.loc 1 61 0
#APP
# 61 "main.c" 1
	rdtsc
# 0 "" 2
.LVL40:
#NO_APP
.LBB22:
.LBB23:
	.loc 2 104 0
	subl	%esi, %eax
.LVL41:
	pushl	$0
	.cfi_def_cfa_offset 20
	pushl	$10000
	.cfi_def_cfa_offset 24
	sbbl	%edi, %edx
	pushl	%edx
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	__udivdi3
.LVL42:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	pushl	%edx
	.cfi_def_cfa_offset 20
	pushl	%eax
	.cfi_def_cfa_offset 24
	pushl	$.LC11
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL43:
.LBE23:
.LBE22:
	.loc 1 63 0
	movl	$0, (%esp)
	call	lwt_info
.LVL44:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L31
	.loc 1 63 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL45:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L31
	.loc 1 63 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL46:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L31
	.loc 1 65 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$fn_bounce
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL47:
	movl	%eax, %esi
.LVL48:
	.loc 1 66 0
	popl	%eax
	.cfi_def_cfa_offset 28
.LVL49:
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_bounce
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL50:
	movl	%eax, %ebx
.LVL51:
	.loc 1 67 0
	movl	%esi, (%esp)
	call	lwt_join
.LVL52:
	.loc 1 68 0
	movl	%ebx, (%esp)
	call	lwt_join
.LVL53:
	.loc 1 69 0
	movl	$0, (%esp)
	call	lwt_info
.LVL54:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L33
	.loc 1 69 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL55:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L33
	.loc 1 69 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL56:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L33
	.loc 1 70 0 is_stmt 1
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
.LVL57:
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
.LVL58:
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL59:
.L31:
	.cfi_restore_state
	.loc 1 63 0
	pushl	$__PRETTY_FUNCTION__.2858
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$63
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL60:
.L33:
	.cfi_restore_state
	.loc 1 69 0
	pushl	$__PRETTY_FUNCTION__.2858
	.cfi_def_cfa_offset 20
	pushl	$69
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL61:
	.cfi_endproc
.LFE40:
	.size	test_perf, .-test_perf
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.str1.4
	.align 4
.LC14:
	.string	"[TEST] thread creation/join/scheduling"
	.align 4
.LC15:
	.string	"(void*)0x37337 == lwt_join(chld1)"
	.align 4
.LC16:
	.string	"lwt_info(LWT_INFO_NTHD_ZOMBIES) == 1"
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.globl	test_crt_join_sched
	.type	test_crt_join_sched, @function
test_crt_join_sched:
.LFB45:
	.loc 1 122 0
	.cfi_startproc
.LVL62:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$20, %esp
	.cfi_def_cfa_offset 28
.LBB24:
.LBB25:
	.loc 2 104 0
	pushl	$.LC14
	.cfi_def_cfa_offset 32
	call	puts
.LVL63:
.LBE25:
.LBE24:
	.loc 1 128 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL64:
	.loc 1 130 0
	popl	%ebx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$fn_sequence
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL65:
	movl	%eax, %ebx
.LVL66:
	.loc 1 131 0
	popl	%eax
	.cfi_def_cfa_offset 28
.LVL67:
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$2
	.cfi_def_cfa_offset 28
	pushl	$fn_sequence
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL68:
	.loc 1 132 0
	movl	%eax, (%esp)
	call	lwt_join
.LVL69:
	.loc 1 133 0
	movl	%ebx, (%esp)
	call	lwt_join
.LVL70:
	.loc 1 134 0
	movl	$0, (%esp)
	call	lwt_info
.LVL71:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L38
	.loc 1 134 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL72:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L38
	.loc 1 134 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL73:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L38
	.loc 1 137 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_null
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL74:
	.loc 1 138 0
	movl	%eax, (%esp)
	call	lwt_join
.LVL75:
	.loc 1 139 0
	movl	$0, (%esp)
	call	lwt_info
.LVL76:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L40
	.loc 1 139 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL77:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L40
	.loc 1 139 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL78:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L40
	.loc 1 141 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_null
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL79:
	movl	%eax, %ebx
.LVL80:
	.loc 1 142 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL81:
	.loc 1 143 0
	movl	%ebx, (%esp)
	call	lwt_join
.LVL82:
	.loc 1 144 0
	movl	$0, (%esp)
	call	lwt_info
.LVL83:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L42
	.loc 1 144 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL84:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L42
	.loc 1 144 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL85:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L42
	.loc 1 146 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_nested_joins
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL86:
	.loc 1 147 0
	movl	%eax, (%esp)
	call	lwt_join
.LVL87:
	.loc 1 148 0
	movl	$0, (%esp)
	call	lwt_info
.LVL88:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L44
	.loc 1 148 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL89:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L44
	.loc 1 148 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL90:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L44
	.loc 1 151 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$226103
	.cfi_def_cfa_offset 28
	pushl	$fn_identity
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL91:
	.loc 1 152 0
	popl	%edx
	.cfi_def_cfa_offset 28
	popl	%ecx
	.cfi_def_cfa_offset 24
	pushl	%eax
	.cfi_def_cfa_offset 28
	pushl	$fn_join
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL92:
	movl	%eax, %ebx
.LVL93:
	.loc 1 153 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL94:
	.loc 1 154 0
	movl	$0, (%esp)
	call	lwt_yield
.LVL95:
	.loc 1 155 0
	movl	%ebx, (%esp)
	call	lwt_join
.LVL96:
	.loc 1 157 0
	movl	$0, (%esp)
	call	lwt_info
.LVL97:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L46
	.loc 1 157 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL98:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L46
	.loc 1 157 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL99:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L46
	.loc 1 160 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$226103
	.cfi_def_cfa_offset 28
	pushl	$fn_identity
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL100:
	.loc 1 161 0
	movl	%eax, (%esp)
	call	lwt_join
.LVL101:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$226103, %eax
	jne	.L54
	.loc 1 162 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL102:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L49
	.loc 1 162 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL103:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L49
	.loc 1 162 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL104:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L49
	.loc 1 165 0 is_stmt 1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	$fn_null
	.cfi_def_cfa_offset 32
	call	lwt_create
.LVL105:
	.loc 1 166 0
	movl	%eax, (%esp)
	.loc 1 165 0
	movl	%eax, %ebx
.LVL106:
	.loc 1 166 0
	call	lwt_yield
.LVL107:
	.loc 1 167 0
	movl	$2, (%esp)
	call	lwt_info
.LVL108:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L55
	.loc 1 168 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	lwt_join
.LVL109:
	.loc 1 169 0
	movl	$0, (%esp)
	call	lwt_info
.LVL110:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$1, %eax
	jne	.L52
	.loc 1 169 0 is_stmt 0 discriminator 2
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL111:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L52
	.loc 1 169 0 discriminator 4
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	lwt_info
.LVL112:
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L52
	.loc 1 170 0 is_stmt 1
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL113:
	ret
.LVL114:
.L38:
	.cfi_restore_state
	.loc 1 134 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$134
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL115:
.L52:
	.cfi_restore_state
	.loc 1 169 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$169
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL116:
.L49:
	.cfi_restore_state
	.loc 1 162 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$162
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL117:
.L46:
	.cfi_restore_state
	.loc 1 157 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$157
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL118:
.L44:
	.cfi_restore_state
	.loc 1 148 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$148
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL119:
.L42:
	.cfi_restore_state
	.loc 1 144 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$144
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL120:
.L40:
	.cfi_restore_state
	.loc 1 139 0
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$139
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL121:
.L55:
	.cfi_restore_state
	.loc 1 167 0 discriminator 1
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	pushl	$167
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC16
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL122:
.L54:
	.cfi_restore_state
	.loc 1 161 0 discriminator 1
	pushl	$__PRETTY_FUNCTION__.2890
	.cfi_def_cfa_offset 20
	pushl	$161
	.cfi_def_cfa_offset 24
	pushl	$.LC4
	.cfi_def_cfa_offset 28
	pushl	$.LC15
	.cfi_def_cfa_offset 32
	call	__assert_fail
.LVL123:
	.cfi_endproc
.LFE45:
	.size	test_crt_join_sched, .-test_crt_join_sched
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.section	.text.startup,"ax",@progbits
.LHOTB18:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB46:
	.loc 1 174 0
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x7c,0x6
	subl	$4, %esp
	.loc 1 175 0
	call	test_perf
.LVL124:
	.loc 1 176 0
	call	test_crt_join_sched
.LVL125:
	.loc 1 179 0
	addl	$4, %esp
	xorl	%eax, %eax
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE46:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE18:
	.section	.text.startup
.LHOTE18:
	.section	.rodata
	.align 4
	.type	__PRETTY_FUNCTION__.2890, @object
	.size	__PRETTY_FUNCTION__.2890, 20
__PRETTY_FUNCTION__.2890:
	.string	"test_crt_join_sched"
	.align 4
	.type	__PRETTY_FUNCTION__.2884, @object
	.size	__PRETTY_FUNCTION__.2884, 8
__PRETTY_FUNCTION__.2884:
	.string	"fn_join"
	.align 4
	.type	__PRETTY_FUNCTION__.2875, @object
	.size	__PRETTY_FUNCTION__.2875, 12
__PRETTY_FUNCTION__.2875:
	.string	"fn_sequence"
	.align 4
	.type	__PRETTY_FUNCTION__.2866, @object
	.size	__PRETTY_FUNCTION__.2866, 16
__PRETTY_FUNCTION__.2866:
	.string	"fn_nested_joins"
	.align 4
	.type	__PRETTY_FUNCTION__.2858, @object
	.size	__PRETTY_FUNCTION__.2858, 10
__PRETTY_FUNCTION__.2858:
	.string	"test_perf"
	.globl	curr
	.bss
	.align 4
	.type	curr, @object
	.size	curr, 4
curr:
	.zero	4
	.globl	sched
	.align 4
	.type	sched, @object
	.size	sched, 8
sched:
	.zero	8
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 3 "/usr/lib/gcc/i686-linux-gnu/5/include/stddef.h"
	.file 4 "/usr/include/i386-linux-gnu/bits/types.h"
	.file 5 "/usr/include/libio.h"
	.file 6 "lwt.h"
	.file 7 "/usr/include/stdio.h"
	.file 8 "/usr/include/assert.h"
	.file 9 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xbbc
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF94
	.byte	0xc
	.long	.LASF95
	.long	.LASF96
	.long	.Ldebug_ranges0+0
	.long	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0xd8
	.long	0x30
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.long	.LASF9
	.byte	0x4
	.byte	0x37
	.long	0x61
	.uleb128 0x2
	.long	.LASF10
	.byte	0x4
	.byte	0x83
	.long	0x85
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.long	.LASF11
	.uleb128 0x2
	.long	.LASF12
	.byte	0x4
	.byte	0x84
	.long	0x6f
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF13
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.byte	0x4
	.long	0xa6
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x7
	.long	.LASF44
	.byte	0x94
	.byte	0x5
	.byte	0xf1
	.long	0x22a
	.uleb128 0x8
	.long	.LASF15
	.byte	0x5
	.byte	0xf2
	.long	0x5a
	.byte	0
	.uleb128 0x8
	.long	.LASF16
	.byte	0x5
	.byte	0xf7
	.long	0xa0
	.byte	0x4
	.uleb128 0x8
	.long	.LASF17
	.byte	0x5
	.byte	0xf8
	.long	0xa0
	.byte	0x8
	.uleb128 0x8
	.long	.LASF18
	.byte	0x5
	.byte	0xf9
	.long	0xa0
	.byte	0xc
	.uleb128 0x8
	.long	.LASF19
	.byte	0x5
	.byte	0xfa
	.long	0xa0
	.byte	0x10
	.uleb128 0x8
	.long	.LASF20
	.byte	0x5
	.byte	0xfb
	.long	0xa0
	.byte	0x14
	.uleb128 0x8
	.long	.LASF21
	.byte	0x5
	.byte	0xfc
	.long	0xa0
	.byte	0x18
	.uleb128 0x8
	.long	.LASF22
	.byte	0x5
	.byte	0xfd
	.long	0xa0
	.byte	0x1c
	.uleb128 0x8
	.long	.LASF23
	.byte	0x5
	.byte	0xfe
	.long	0xa0
	.byte	0x20
	.uleb128 0x9
	.long	.LASF24
	.byte	0x5
	.value	0x100
	.long	0xa0
	.byte	0x24
	.uleb128 0x9
	.long	.LASF25
	.byte	0x5
	.value	0x101
	.long	0xa0
	.byte	0x28
	.uleb128 0x9
	.long	.LASF26
	.byte	0x5
	.value	0x102
	.long	0xa0
	.byte	0x2c
	.uleb128 0x9
	.long	.LASF27
	.byte	0x5
	.value	0x104
	.long	0x262
	.byte	0x30
	.uleb128 0x9
	.long	.LASF28
	.byte	0x5
	.value	0x106
	.long	0x268
	.byte	0x34
	.uleb128 0x9
	.long	.LASF29
	.byte	0x5
	.value	0x108
	.long	0x5a
	.byte	0x38
	.uleb128 0x9
	.long	.LASF30
	.byte	0x5
	.value	0x10c
	.long	0x5a
	.byte	0x3c
	.uleb128 0x9
	.long	.LASF31
	.byte	0x5
	.value	0x10e
	.long	0x7a
	.byte	0x40
	.uleb128 0x9
	.long	.LASF32
	.byte	0x5
	.value	0x112
	.long	0x3e
	.byte	0x44
	.uleb128 0x9
	.long	.LASF33
	.byte	0x5
	.value	0x113
	.long	0x4c
	.byte	0x46
	.uleb128 0x9
	.long	.LASF34
	.byte	0x5
	.value	0x114
	.long	0x26e
	.byte	0x47
	.uleb128 0x9
	.long	.LASF35
	.byte	0x5
	.value	0x118
	.long	0x27e
	.byte	0x48
	.uleb128 0x9
	.long	.LASF36
	.byte	0x5
	.value	0x121
	.long	0x8c
	.byte	0x4c
	.uleb128 0x9
	.long	.LASF37
	.byte	0x5
	.value	0x129
	.long	0x9e
	.byte	0x54
	.uleb128 0x9
	.long	.LASF38
	.byte	0x5
	.value	0x12a
	.long	0x9e
	.byte	0x58
	.uleb128 0x9
	.long	.LASF39
	.byte	0x5
	.value	0x12b
	.long	0x9e
	.byte	0x5c
	.uleb128 0x9
	.long	.LASF40
	.byte	0x5
	.value	0x12c
	.long	0x9e
	.byte	0x60
	.uleb128 0x9
	.long	.LASF41
	.byte	0x5
	.value	0x12e
	.long	0x25
	.byte	0x64
	.uleb128 0x9
	.long	.LASF42
	.byte	0x5
	.value	0x12f
	.long	0x5a
	.byte	0x68
	.uleb128 0x9
	.long	.LASF43
	.byte	0x5
	.value	0x131
	.long	0x284
	.byte	0x6c
	.byte	0
	.uleb128 0xa
	.long	.LASF97
	.byte	0x5
	.byte	0x96
	.uleb128 0x7
	.long	.LASF45
	.byte	0xc
	.byte	0x5
	.byte	0x9c
	.long	0x262
	.uleb128 0x8
	.long	.LASF46
	.byte	0x5
	.byte	0x9d
	.long	0x262
	.byte	0
	.uleb128 0x8
	.long	.LASF47
	.byte	0x5
	.byte	0x9e
	.long	0x268
	.byte	0x4
	.uleb128 0x8
	.long	.LASF48
	.byte	0x5
	.byte	0xa2
	.long	0x5a
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x231
	.uleb128 0x6
	.byte	0x4
	.long	0xad
	.uleb128 0xb
	.long	0xa6
	.long	0x27e
	.uleb128 0xc
	.long	0x97
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x22a
	.uleb128 0xb
	.long	0xa6
	.long	0x294
	.uleb128 0xc
	.long	0x97
	.byte	0x27
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x29a
	.uleb128 0xd
	.long	0xa6
	.uleb128 0xe
	.long	0x5a
	.uleb128 0x2
	.long	.LASF49
	.byte	0x6
	.byte	0x11
	.long	0x5a
	.uleb128 0xf
	.long	.LASF98
	.byte	0x4
	.long	0x30
	.byte	0x6
	.byte	0x17
	.long	0x2d2
	.uleb128 0x10
	.long	.LASF50
	.byte	0
	.uleb128 0x10
	.long	.LASF51
	.byte	0x1
	.uleb128 0x10
	.long	.LASF52
	.byte	0x2
	.byte	0
	.uleb128 0x2
	.long	.LASF53
	.byte	0x6
	.byte	0x20
	.long	0x2af
	.uleb128 0x7
	.long	.LASF54
	.byte	0x8
	.byte	0x6
	.byte	0x23
	.long	0x300
	.uleb128 0x11
	.string	"ip"
	.byte	0x6
	.byte	0x25
	.long	0x30
	.byte	0
	.uleb128 0x11
	.string	"sp"
	.byte	0x6
	.byte	0x25
	.long	0x30
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.long	.LASF55
	.byte	0x6
	.byte	0x27
	.long	0x2dd
	.uleb128 0x7
	.long	.LASF56
	.byte	0x28
	.byte	0x6
	.byte	0x2a
	.long	0x384
	.uleb128 0x8
	.long	.LASF57
	.byte	0x6
	.byte	0x2d
	.long	0x2a4
	.byte	0
	.uleb128 0x8
	.long	.LASF58
	.byte	0x6
	.byte	0x30
	.long	0x2d2
	.byte	0x4
	.uleb128 0x8
	.long	.LASF59
	.byte	0x6
	.byte	0x33
	.long	0x384
	.byte	0x8
	.uleb128 0x8
	.long	.LASF60
	.byte	0x6
	.byte	0x34
	.long	0x384
	.byte	0xc
	.uleb128 0x8
	.long	.LASF61
	.byte	0x6
	.byte	0x37
	.long	0x384
	.byte	0x10
	.uleb128 0x8
	.long	.LASF62
	.byte	0x6
	.byte	0x38
	.long	0x384
	.byte	0x14
	.uleb128 0x8
	.long	.LASF63
	.byte	0x6
	.byte	0x3b
	.long	0x30
	.byte	0x18
	.uleb128 0x8
	.long	.LASF64
	.byte	0x6
	.byte	0x3e
	.long	0x9e
	.byte	0x1c
	.uleb128 0x8
	.long	.LASF65
	.byte	0x6
	.byte	0x41
	.long	0x300
	.byte	0x20
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x30b
	.uleb128 0x2
	.long	.LASF66
	.byte	0x6
	.byte	0x43
	.long	0x384
	.uleb128 0x12
	.long	.LASF99
	.byte	0x2
	.byte	0x66
	.long	0x5a
	.byte	0x3
	.long	0x3b2
	.uleb128 0x13
	.long	.LASF67
	.byte	0x2
	.byte	0x66
	.long	0x3b2
	.uleb128 0x14
	.byte	0
	.uleb128 0x15
	.long	0x294
	.uleb128 0x16
	.long	.LASF70
	.byte	0x1
	.byte	0x5f
	.long	0x9e
	.byte	0x1
	.long	0x3fd
	.uleb128 0x17
	.string	"d"
	.byte	0x1
	.byte	0x5f
	.long	0x9e
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0x61
	.long	0x5a
	.uleb128 0x19
	.long	.LASF68
	.byte	0x1
	.byte	0x61
	.long	0x5a
	.uleb128 0x18
	.string	"val"
	.byte	0x1
	.byte	0x61
	.long	0x5a
	.uleb128 0x1a
	.long	.LASF69
	.long	0x40d
	.long	.LASF70
	.byte	0
	.uleb128 0xb
	.long	0x29a
	.long	0x40d
	.uleb128 0xc
	.long	0x97
	.byte	0xb
	.byte	0
	.uleb128 0xd
	.long	0x3fd
	.uleb128 0x16
	.long	.LASF71
	.byte	0x1
	.byte	0x6f
	.long	0x9e
	.byte	0x1
	.long	0x44b
	.uleb128 0x17
	.string	"d"
	.byte	0x1
	.byte	0x6f
	.long	0x9e
	.uleb128 0x18
	.string	"t"
	.byte	0x1
	.byte	0x71
	.long	0x38a
	.uleb128 0x18
	.string	"r"
	.byte	0x1
	.byte	0x72
	.long	0x9e
	.uleb128 0x1a
	.long	.LASF69
	.long	0x45b
	.long	.LASF71
	.byte	0
	.uleb128 0xb
	.long	0x29a
	.long	0x45b
	.uleb128 0xc
	.long	0x97
	.byte	0x7
	.byte	0
	.uleb128 0xd
	.long	0x44b
	.uleb128 0x16
	.long	.LASF72
	.byte	0x1
	.byte	0x4d
	.long	0x9e
	.byte	0x1
	.long	0x492
	.uleb128 0x17
	.string	"d"
	.byte	0x1
	.byte	0x4d
	.long	0x9e
	.uleb128 0x19
	.long	.LASF73
	.byte	0x1
	.byte	0x4f
	.long	0x38a
	.uleb128 0x1a
	.long	.LASF69
	.long	0x4a2
	.long	.LASF72
	.byte	0
	.uleb128 0xb
	.long	0x29a
	.long	0x4a2
	.uleb128 0xc
	.long	0x97
	.byte	0xf
	.byte	0
	.uleb128 0xd
	.long	0x492
	.uleb128 0x1b
	.long	.LASF74
	.byte	0x1
	.byte	0x27
	.long	0x9e
	.long	.LFB39
	.long	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.long	0x4cd
	.uleb128 0x1c
	.string	"d"
	.byte	0x1
	.byte	0x27
	.long	0x9e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1b
	.long	.LASF75
	.byte	0x1
	.byte	0x49
	.long	0x9e
	.long	.LFB41
	.long	.LFE41-.LFB41
	.uleb128 0x1
	.byte	0x9c
	.long	0x4f3
	.uleb128 0x1c
	.string	"d"
	.byte	0x1
	.byte	0x49
	.long	0x9e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x1d
	.long	.LASF76
	.byte	0x1
	.byte	0x14
	.long	0x9e
	.long	.LFB38
	.long	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x599
	.uleb128 0x1c
	.string	"d"
	.byte	0x1
	.byte	0x14
	.long	0x9e
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x1e
	.string	"i"
	.byte	0x1
	.byte	0x16
	.long	0x5a
	.long	.LLST0
	.uleb128 0x1f
	.long	.LASF77
	.byte	0x1
	.byte	0x17
	.long	0x68
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1e
	.string	"end"
	.byte	0x1
	.byte	0x17
	.long	0x68
	.long	.LLST1
	.uleb128 0x20
	.long	0x395
	.long	.LBB8
	.long	.LBE8-.LBB8
	.byte	0x1
	.byte	0x21
	.long	0x56b
	.uleb128 0x21
	.long	0x3a5
	.uleb128 0x6
	.byte	0x3
	.long	.LC2
	.byte	0x9f
	.uleb128 0x22
	.long	.LVL15
	.long	0xb37
	.byte	0
	.uleb128 0x22
	.long	.LVL3
	.long	0xb42
	.uleb128 0x22
	.long	.LVL4
	.long	0xb42
	.uleb128 0x22
	.long	.LVL7
	.long	0xb42
	.uleb128 0x22
	.long	.LVL9
	.long	0xb42
	.uleb128 0x22
	.long	.LVL10
	.long	0xb42
	.byte	0
	.uleb128 0x23
	.long	0x3b7
	.long	.LFB43
	.long	.LFE43-.LFB43
	.uleb128 0x1
	.byte	0x9c
	.long	0x622
	.uleb128 0x21
	.long	0x3c7
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x24
	.long	0x3d0
	.uleb128 0x25
	.long	0x3d9
	.long	.LLST2
	.uleb128 0x25
	.long	0x3e4
	.long	.LLST3
	.uleb128 0x26
	.long	0x3ef
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2875
	.uleb128 0x27
	.long	.LBB12
	.long	.LBE12-.LBB12
	.long	0x618
	.uleb128 0x21
	.long	0x3c7
	.uleb128 0x1
	.byte	0x56
	.uleb128 0x28
	.long	.LBB13
	.long	.LBE13-.LBB13
	.uleb128 0x24
	.long	0x3d0
	.uleb128 0x24
	.long	0x3d9
	.uleb128 0x24
	.long	0x3e4
	.uleb128 0x26
	.long	0x3ef
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2875
	.uleb128 0x22
	.long	.LVL22
	.long	0xb4d
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LVL19
	.long	0xb42
	.byte	0
	.uleb128 0x23
	.long	0x412
	.long	.LFB44
	.long	.LFE44-.LFB44
	.uleb128 0x1
	.byte	0x9c
	.long	0x6a1
	.uleb128 0x21
	.long	0x422
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x26
	.long	0x42b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.long	0x434
	.long	.LLST4
	.uleb128 0x26
	.long	0x43d
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2884
	.uleb128 0x27
	.long	.LBB16
	.long	.LBE16-.LBB16
	.long	0x697
	.uleb128 0x21
	.long	0x422
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LBB17
	.long	.LBE17-.LBB17
	.uleb128 0x24
	.long	0x42b
	.uleb128 0x24
	.long	0x434
	.uleb128 0x26
	.long	0x43d
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2884
	.uleb128 0x22
	.long	.LVL28
	.long	0xb4d
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LVL25
	.long	0xb58
	.byte	0
	.uleb128 0x23
	.long	0x460
	.long	.LFB42
	.long	.LFE42-.LFB42
	.uleb128 0x1
	.byte	0x9c
	.long	0x740
	.uleb128 0x21
	.long	0x470
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.long	0x479
	.long	.LLST5
	.uleb128 0x26
	.long	0x484
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2866
	.uleb128 0x27
	.long	.LBB20
	.long	.LBE20-.LBB20
	.long	0x709
	.uleb128 0x21
	.long	0x470
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x28
	.long	.LBB21
	.long	.LBE21-.LBB21
	.uleb128 0x24
	.long	0x479
	.uleb128 0x26
	.long	0x484
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2866
	.uleb128 0x22
	.long	.LVL36
	.long	0xb4d
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LVL30
	.long	0xb42
	.uleb128 0x22
	.long	.LVL31
	.long	0xb42
	.uleb128 0x22
	.long	.LVL32
	.long	0xb63
	.uleb128 0x22
	.long	.LVL33
	.long	0xb6e
	.uleb128 0x22
	.long	.LVL34
	.long	0xb79
	.uleb128 0x29
	.long	.LVL35
	.long	0xb58
	.byte	0
	.uleb128 0x2a
	.long	.LASF80
	.byte	0x1
	.byte	0x30
	.long	.LFB40
	.long	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.long	0x84e
	.uleb128 0x2b
	.long	.LASF78
	.byte	0x1
	.byte	0x32
	.long	0x38a
	.long	.LLST6
	.uleb128 0x2b
	.long	.LASF79
	.byte	0x1
	.byte	0x32
	.long	0x38a
	.long	.LLST7
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0x33
	.long	0x5a
	.uleb128 0x2b
	.long	.LASF77
	.byte	0x1
	.byte	0x34
	.long	0x68
	.long	.LLST8
	.uleb128 0x1e
	.string	"end"
	.byte	0x1
	.byte	0x34
	.long	0x68
	.long	.LLST9
	.uleb128 0x2c
	.long	.LASF69
	.long	0x85e
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2858
	.uleb128 0x20
	.long	0x395
	.long	.LBB22
	.long	.LBE22-.LBB22
	.byte	0x1
	.byte	0x3e
	.long	0x7cf
	.uleb128 0x2d
	.long	0x3a5
	.long	.LLST10
	.uleb128 0x22
	.long	.LVL43
	.long	0xb37
	.byte	0
	.uleb128 0x22
	.long	.LVL38
	.long	0xb79
	.uleb128 0x22
	.long	.LVL39
	.long	0xb58
	.uleb128 0x22
	.long	.LVL44
	.long	0xb63
	.uleb128 0x22
	.long	.LVL45
	.long	0xb63
	.uleb128 0x22
	.long	.LVL46
	.long	0xb63
	.uleb128 0x22
	.long	.LVL47
	.long	0xb79
	.uleb128 0x22
	.long	.LVL50
	.long	0xb79
	.uleb128 0x22
	.long	.LVL52
	.long	0xb58
	.uleb128 0x22
	.long	.LVL53
	.long	0xb58
	.uleb128 0x22
	.long	.LVL54
	.long	0xb63
	.uleb128 0x22
	.long	.LVL55
	.long	0xb63
	.uleb128 0x22
	.long	.LVL56
	.long	0xb63
	.uleb128 0x22
	.long	.LVL60
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL61
	.long	0xb4d
	.byte	0
	.uleb128 0xb
	.long	0x29a
	.long	0x85e
	.uleb128 0xc
	.long	0x97
	.byte	0x9
	.byte	0
	.uleb128 0xd
	.long	0x84e
	.uleb128 0x2e
	.long	.LASF81
	.byte	0x1
	.byte	0x79
	.long	.LFB45
	.long	.LFE45-.LFB45
	.uleb128 0x1
	.byte	0x9c
	.long	0xaa9
	.uleb128 0x2b
	.long	.LASF78
	.byte	0x1
	.byte	0x7b
	.long	0x38a
	.long	.LLST11
	.uleb128 0x2b
	.long	.LASF79
	.byte	0x1
	.byte	0x7b
	.long	0x38a
	.long	.LLST12
	.uleb128 0x2c
	.long	.LASF69
	.long	0xab9
	.uleb128 0x5
	.byte	0x3
	.long	__PRETTY_FUNCTION__.2890
	.uleb128 0x20
	.long	0x395
	.long	.LBB24
	.long	.LBE24-.LBB24
	.byte	0x1
	.byte	0x7d
	.long	0x8cb
	.uleb128 0x2d
	.long	0x3a5
	.long	.LLST13
	.uleb128 0x22
	.long	.LVL63
	.long	0xbb0
	.byte	0
	.uleb128 0x22
	.long	.LVL64
	.long	0xb42
	.uleb128 0x22
	.long	.LVL65
	.long	0xb79
	.uleb128 0x22
	.long	.LVL68
	.long	0xb79
	.uleb128 0x22
	.long	.LVL69
	.long	0xb58
	.uleb128 0x22
	.long	.LVL70
	.long	0xb58
	.uleb128 0x22
	.long	.LVL71
	.long	0xb63
	.uleb128 0x22
	.long	.LVL72
	.long	0xb63
	.uleb128 0x22
	.long	.LVL73
	.long	0xb63
	.uleb128 0x22
	.long	.LVL74
	.long	0xb79
	.uleb128 0x22
	.long	.LVL75
	.long	0xb58
	.uleb128 0x22
	.long	.LVL76
	.long	0xb63
	.uleb128 0x22
	.long	.LVL77
	.long	0xb63
	.uleb128 0x22
	.long	.LVL78
	.long	0xb63
	.uleb128 0x22
	.long	.LVL79
	.long	0xb79
	.uleb128 0x22
	.long	.LVL81
	.long	0xb42
	.uleb128 0x22
	.long	.LVL82
	.long	0xb58
	.uleb128 0x22
	.long	.LVL83
	.long	0xb63
	.uleb128 0x22
	.long	.LVL84
	.long	0xb63
	.uleb128 0x22
	.long	.LVL85
	.long	0xb63
	.uleb128 0x22
	.long	.LVL86
	.long	0xb79
	.uleb128 0x22
	.long	.LVL87
	.long	0xb58
	.uleb128 0x22
	.long	.LVL88
	.long	0xb63
	.uleb128 0x22
	.long	.LVL89
	.long	0xb63
	.uleb128 0x22
	.long	.LVL90
	.long	0xb63
	.uleb128 0x22
	.long	.LVL91
	.long	0xb79
	.uleb128 0x22
	.long	.LVL92
	.long	0xb79
	.uleb128 0x22
	.long	.LVL94
	.long	0xb42
	.uleb128 0x22
	.long	.LVL95
	.long	0xb42
	.uleb128 0x22
	.long	.LVL96
	.long	0xb58
	.uleb128 0x22
	.long	.LVL97
	.long	0xb63
	.uleb128 0x22
	.long	.LVL98
	.long	0xb63
	.uleb128 0x22
	.long	.LVL99
	.long	0xb63
	.uleb128 0x22
	.long	.LVL100
	.long	0xb79
	.uleb128 0x22
	.long	.LVL101
	.long	0xb58
	.uleb128 0x22
	.long	.LVL102
	.long	0xb63
	.uleb128 0x22
	.long	.LVL103
	.long	0xb63
	.uleb128 0x22
	.long	.LVL104
	.long	0xb63
	.uleb128 0x22
	.long	.LVL105
	.long	0xb79
	.uleb128 0x22
	.long	.LVL107
	.long	0xb42
	.uleb128 0x22
	.long	.LVL108
	.long	0xb63
	.uleb128 0x22
	.long	.LVL109
	.long	0xb58
	.uleb128 0x22
	.long	.LVL110
	.long	0xb63
	.uleb128 0x22
	.long	.LVL111
	.long	0xb63
	.uleb128 0x22
	.long	.LVL112
	.long	0xb63
	.uleb128 0x22
	.long	.LVL115
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL116
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL117
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL118
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL119
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL120
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL121
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL122
	.long	0xb4d
	.uleb128 0x22
	.long	.LVL123
	.long	0xb4d
	.byte	0
	.uleb128 0xb
	.long	0x29a
	.long	0xab9
	.uleb128 0xc
	.long	0x97
	.byte	0x13
	.byte	0
	.uleb128 0xd
	.long	0xaa9
	.uleb128 0x1b
	.long	.LASF82
	.byte	0x1
	.byte	0xad
	.long	0x5a
	.long	.LFB46
	.long	.LFE46-.LFB46
	.uleb128 0x1
	.byte	0x9c
	.long	0xaea
	.uleb128 0x22
	.long	.LVL124
	.long	0x740
	.uleb128 0x22
	.long	.LVL125
	.long	0x863
	.byte	0
	.uleb128 0x2f
	.long	.LASF83
	.byte	0x7
	.byte	0xa8
	.long	0x268
	.uleb128 0x2f
	.long	.LASF84
	.byte	0x7
	.byte	0xa9
	.long	0x268
	.uleb128 0xb
	.long	0x29f
	.long	0xb10
	.uleb128 0xc
	.long	0x97
	.byte	0x1
	.byte	0
	.uleb128 0x30
	.long	.LASF85
	.byte	0x1
	.byte	0x5b
	.long	0xb21
	.uleb128 0x5
	.byte	0x3
	.long	sched
	.uleb128 0xe
	.long	0xb00
	.uleb128 0x30
	.long	.LASF86
	.byte	0x1
	.byte	0x5c
	.long	0x29f
	.uleb128 0x5
	.byte	0x3
	.long	curr
	.uleb128 0x31
	.long	.LASF87
	.long	.LASF87
	.byte	0x2
	.byte	0x57
	.uleb128 0x31
	.long	.LASF88
	.long	.LASF88
	.byte	0x6
	.byte	0x52
	.uleb128 0x31
	.long	.LASF89
	.long	.LASF89
	.byte	0x8
	.byte	0x45
	.uleb128 0x31
	.long	.LASF90
	.long	.LASF90
	.byte	0x6
	.byte	0x50
	.uleb128 0x31
	.long	.LASF91
	.long	.LASF91
	.byte	0x6
	.byte	0x55
	.uleb128 0x31
	.long	.LASF92
	.long	.LASF92
	.byte	0x6
	.byte	0x51
	.uleb128 0x31
	.long	.LASF93
	.long	.LASF93
	.byte	0x6
	.byte	0x4f
	.uleb128 0x32
	.uleb128 0x2a
	.byte	0x9e
	.uleb128 0x28
	.byte	0x5b
	.byte	0x54
	.byte	0x45
	.byte	0x53
	.byte	0x54
	.byte	0x5d
	.byte	0x20
	.byte	0x74
	.byte	0x68
	.byte	0x72
	.byte	0x65
	.byte	0x61
	.byte	0x64
	.byte	0x20
	.byte	0x63
	.byte	0x72
	.byte	0x65
	.byte	0x61
	.byte	0x74
	.byte	0x69
	.byte	0x6f
	.byte	0x6e
	.byte	0x2f
	.byte	0x6a
	.byte	0x6f
	.byte	0x69
	.byte	0x6e
	.byte	0x2f
	.byte	0x73
	.byte	0x63
	.byte	0x68
	.byte	0x65
	.byte	0x64
	.byte	0x75
	.byte	0x6c
	.byte	0x69
	.byte	0x6e
	.byte	0x67
	.byte	0xa
	.byte	0
	.uleb128 0x33
	.long	.LASF100
	.long	.LASF101
	.byte	0x9
	.byte	0
	.long	.LASF100
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1c
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x36
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LVL5
	.long	.LVL6
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST1:
	.long	.LVL8
	.long	.LVL11
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL12
	.long	.LVL13
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST2:
	.long	.LVL18
	.long	.LVL19-1
	.value	0x1
	.byte	0x52
	.long	.LVL21
	.long	.LVL22-1
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST3:
	.long	.LVL17
	.long	.LVL20
	.value	0x1
	.byte	0x56
	.long	.LVL20
	.long	.LVL21
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL21
	.long	.LFE43
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST4:
	.long	.LVL25
	.long	.LVL26
	.value	0x1
	.byte	0x50
	.long	.LVL27
	.long	.LVL28-1
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST5:
	.long	.LVL34
	.long	.LVL35-1
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST6:
	.long	.LVL38
	.long	.LVL39-1
	.value	0x1
	.byte	0x50
	.long	.LVL48
	.long	.LVL49
	.value	0x1
	.byte	0x50
	.long	.LVL49
	.long	.LVL58
	.value	0x1
	.byte	0x56
	.long	.LVL60
	.long	.LFE40
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST7:
	.long	.LVL51
	.long	.LVL52-1
	.value	0x1
	.byte	0x50
	.long	.LVL52-1
	.long	.LVL57
	.value	0x1
	.byte	0x53
	.long	.LVL60
	.long	.LFE40
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST8:
	.long	.LVL37
	.long	.LVL48
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	.LVL59
	.long	.LVL60
	.value	0x6
	.byte	0x56
	.byte	0x93
	.uleb128 0x4
	.byte	0x57
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST9:
	.long	.LVL40
	.long	.LVL41
	.value	0x6
	.byte	0x50
	.byte	0x93
	.uleb128 0x4
	.byte	0x52
	.byte	0x93
	.uleb128 0x4
	.long	0
	.long	0
.LLST10:
	.long	.LVL40
	.long	.LVL43
	.value	0x6
	.byte	0x3
	.long	.LC11
	.byte	0x9f
	.long	0
	.long	0
.LLST11:
	.long	.LVL66
	.long	.LVL67
	.value	0x1
	.byte	0x50
	.long	.LVL67
	.long	.LVL74
	.value	0x1
	.byte	0x53
	.long	.LVL74
	.long	.LVL75-1
	.value	0x1
	.byte	0x50
	.long	.LVL80
	.long	.LVL81-1
	.value	0x1
	.byte	0x50
	.long	.LVL81-1
	.long	.LVL86
	.value	0x1
	.byte	0x53
	.long	.LVL86
	.long	.LVL87-1
	.value	0x1
	.byte	0x50
	.long	.LVL91
	.long	.LVL92-1
	.value	0x1
	.byte	0x50
	.long	.LVL100
	.long	.LVL101-1
	.value	0x1
	.byte	0x50
	.long	.LVL106
	.long	.LVL107-1
	.value	0x1
	.byte	0x50
	.long	.LVL107-1
	.long	.LVL113
	.value	0x1
	.byte	0x53
	.long	.LVL114
	.long	.LVL116
	.value	0x1
	.byte	0x53
	.long	.LVL119
	.long	.LVL120
	.value	0x1
	.byte	0x53
	.long	.LVL121
	.long	.LVL122
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST12:
	.long	.LVL68
	.long	.LVL69-1
	.value	0x1
	.byte	0x50
	.long	.LVL93
	.long	.LVL94-1
	.value	0x1
	.byte	0x50
	.long	.LVL94-1
	.long	.LVL106
	.value	0x1
	.byte	0x53
	.long	.LVL116
	.long	.LVL118
	.value	0x1
	.byte	0x53
	.long	.LVL122
	.long	.LFE45
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST13:
	.long	.LVL62
	.long	.LVL63
	.value	0x6
	.byte	0xf2
	.long	.Ldebug_info0+2948
	.sleb128 0
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x24
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.LFB46
	.long	.LFE46-.LFB46
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.Ltext0
	.long	.Letext0
	.long	.LFB46
	.long	.LFE46
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF99:
	.string	"printf"
.LASF10:
	.string	"__off_t"
.LASF16:
	.string	"_IO_read_ptr"
.LASF28:
	.string	"_chain"
.LASF8:
	.string	"size_t"
.LASF76:
	.string	"fn_bounce"
.LASF34:
	.string	"_shortbuf"
.LASF49:
	.string	"t_id"
.LASF60:
	.string	"prev"
.LASF63:
	.string	"init_sp"
.LASF22:
	.string	"_IO_buf_base"
.LASF7:
	.string	"long long unsigned int"
.LASF59:
	.string	"next"
.LASF6:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF69:
	.string	"__PRETTY_FUNCTION__"
.LASF68:
	.string	"other"
.LASF53:
	.string	"lwt_info_t"
.LASF29:
	.string	"_fileno"
.LASF17:
	.string	"_IO_read_end"
.LASF52:
	.string	"LWT_INFO_NTHD_ZOMBIES"
.LASF11:
	.string	"long int"
.LASF15:
	.string	"_flags"
.LASF23:
	.string	"_IO_buf_end"
.LASF32:
	.string	"_cur_column"
.LASF9:
	.string	"__quad_t"
.LASF87:
	.string	"__printf_chk"
.LASF31:
	.string	"_old_offset"
.LASF36:
	.string	"_offset"
.LASF98:
	.string	"_lwt_info_t"
.LASF56:
	.string	"_lwt_t"
.LASF75:
	.string	"fn_identity"
.LASF55:
	.string	"lwt_context"
.LASF45:
	.string	"_IO_marker"
.LASF83:
	.string	"stdin"
.LASF51:
	.string	"LWT_INFO_NTHD_BLOCKED"
.LASF0:
	.string	"unsigned int"
.LASF3:
	.string	"long unsigned int"
.LASF20:
	.string	"_IO_write_ptr"
.LASF47:
	.string	"_sbuf"
.LASF2:
	.string	"short unsigned int"
.LASF57:
	.string	"lwt_id"
.LASF96:
	.string	"/root/works/lwt-v1-sudo-rm-rf"
.LASF24:
	.string	"_IO_save_base"
.LASF95:
	.string	"main.c"
.LASF35:
	.string	"_lock"
.LASF30:
	.string	"_flags2"
.LASF42:
	.string	"_mode"
.LASF101:
	.string	"__builtin_puts"
.LASF84:
	.string	"stdout"
.LASF80:
	.string	"test_perf"
.LASF100:
	.string	"puts"
.LASF72:
	.string	"fn_nested_joins"
.LASF13:
	.string	"sizetype"
.LASF92:
	.string	"lwt_die"
.LASF61:
	.string	"merge_to"
.LASF94:
	.string	"GNU C11 5.3.1 20160413 -mtune=generic -march=i686 -g -O3 -fstack-protector-strong"
.LASF71:
	.string	"fn_join"
.LASF97:
	.string	"_IO_lock_t"
.LASF44:
	.string	"_IO_FILE"
.LASF62:
	.string	"wait_merge"
.LASF48:
	.string	"_pos"
.LASF73:
	.string	"chld"
.LASF27:
	.string	"_markers"
.LASF89:
	.string	"__assert_fail"
.LASF91:
	.string	"lwt_info"
.LASF54:
	.string	"_lwt_context"
.LASF1:
	.string	"unsigned char"
.LASF86:
	.string	"curr"
.LASF5:
	.string	"short int"
.LASF64:
	.string	"last_word"
.LASF88:
	.string	"lwt_yield"
.LASF33:
	.string	"_vtable_offset"
.LASF93:
	.string	"lwt_create"
.LASF90:
	.string	"lwt_join"
.LASF14:
	.string	"char"
.LASF46:
	.string	"_next"
.LASF12:
	.string	"__off64_t"
.LASF18:
	.string	"_IO_read_base"
.LASF85:
	.string	"sched"
.LASF26:
	.string	"_IO_save_end"
.LASF65:
	.string	"context"
.LASF67:
	.string	"__fmt"
.LASF37:
	.string	"__pad1"
.LASF38:
	.string	"__pad2"
.LASF39:
	.string	"__pad3"
.LASF40:
	.string	"__pad4"
.LASF41:
	.string	"__pad5"
.LASF21:
	.string	"_IO_write_end"
.LASF43:
	.string	"_unused2"
.LASF58:
	.string	"status"
.LASF70:
	.string	"fn_sequence"
.LASF81:
	.string	"test_crt_join_sched"
.LASF25:
	.string	"_IO_backup_base"
.LASF78:
	.string	"chld1"
.LASF79:
	.string	"chld2"
.LASF77:
	.string	"start"
.LASF50:
	.string	"LWT_INFO_NTHD_RUNNABLE"
.LASF82:
	.string	"main"
.LASF19:
	.string	"_IO_write_base"
.LASF66:
	.string	"lwt_t"
.LASF74:
	.string	"fn_null"
	.ident	"GCC: (Ubuntu 5.3.1-14ubuntu2) 5.3.1 20160413"
	.section	.note.GNU-stack,"",@progbits
