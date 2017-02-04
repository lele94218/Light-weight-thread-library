	.file	"lwt.c"
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
	.globl	__lwt_trampoline
	.type	__lwt_trampoline, @function
__lwt_trampoline:
.LFB50:
	.file 1 "lwt.c"
	.loc 1 346 0
	.cfi_startproc
.LVL0:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 347 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	32(%esp)
	.cfi_def_cfa_offset 32
	call	*32(%esp)
.LVL1:
.LBB59:
.LBB60:
	.loc 1 314 0
	movl	current_thread, %edx
	.loc 1 316 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	movl	16(%edx), %ecx
	.loc 1 314 0
	movl	%eax, 28(%edx)
	.loc 1 316 0
	testl	%ecx, %ecx
	je	.L2
	.loc 1 318 0
	movl	$0, 4(%ecx)
	.loc 1 319 0
	movl	%eax, 28(%ecx)
	.loc 1 322 0
	movl	valid_queue, %ecx
.LVL2:
	.loc 1 320 0
	movl	$0, 16(%edx)
	.loc 1 321 0
	movl	$2, 4(%edx)
.LBB61:
.LBB62:
	.loc 1 90 0
	movl	8(%ecx), %esi
	.loc 1 89 0
	movl	(%ecx), %ebx
.LVL3:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L3
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L3
	.loc 1 93 0
	cmpl	%edx, %ebx
	je	.L4
	movl	%ebx, %eax
.LVL4:
	jmp	.L6
.LVL5:
	.p2align 4,,10
	.p2align 3
.L14:
	cmpl	%eax, %edx
	je	.L93
.L6:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL6:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L14
.LVL7:
.L3:
.LBE62:
.LBE61:
	.loc 1 323 0
	movl	recycle_queue, %eax
.LVL8:
.LBB66:
.LBB67:
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	movl	8(%eax), %ebx
	testl	%ebx, %ebx
	je	.L94
	.loc 1 52 0
	movl	4(%eax), %esi
	movl	%edx, 8(%esi)
	.loc 1 53 0
	movl	%esi, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%eax)
.L16:
	.loc 1 57 0
	addl	$1, %ebx
	movl	%ebx, 8(%eax)
.LVL9:
.L17:
.LBE67:
.LBE66:
.LBB69:
.LBB70:
.LBB71:
.LBB72:
	.loc 1 137 0
	movl	(%ecx), %eax
.LBE72:
.LBE71:
	.loc 1 188 0
	movl	%edx, old_thread
.LVL10:
.LBB74:
.LBB73:
	.loc 1 138 0
	testl	%eax, %eax
	jne	.L36
	jmp	.L32
.LVL11:
	.p2align 4,,10
	.p2align 3
.L95:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL12:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L32
.LVL13:
.L36:
	.loc 1 140 0
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L95
.LVL14:
.LBE73:
.LBE74:
	.loc 1 190 0
	cmpl	%eax, %edx
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L37
.LVL15:
.LBB75:
.LBB76:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
#NO_APP
.L37:
.LBE76:
.LBE75:
.LBE70:
.LBE69:
.LBE60:
.LBE59:
	.loc 1 352 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	xorl	%eax, %eax
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL16:
	.p2align 4,,10
	.p2align 3
.L94:
	.cfi_restore_state
.LBB96:
.LBB93:
.LBB78:
.LBB68:
	.loc 1 46 0
	movl	%edx, (%eax)
	.loc 1 47 0
	movl	%edx, 4(%eax)
	jmp	.L16
.LVL17:
	.p2align 4,,10
	.p2align 3
.L32:
.LBE68:
.LBE78:
.LBE93:
.LBE96:
	.loc 1 352 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	xorl	%eax, %eax
.LBB97:
.LBB94:
.LBB79:
.LBB77:
	.loc 1 189 0
	movl	$0, current_thread
.LBE77:
.LBE79:
.LBE94:
.LBE97:
	.loc 1 352 0
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL18:
	.p2align 4,,10
	.p2align 3
.L93:
	.cfi_restore_state
.LBB98:
.LBB95:
.LBB80:
.LBB63:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L39
	.loc 1 102 0
	cmpl	%edx, %ebx
	je	.L40
	.loc 1 110 0
	cmpl	%edx, 4(%ecx)
	je	.L96
	.loc 1 118 0
	movl	12(%edx), %ebx
	testl	%ebx, %ebx
	je	.L12
	.loc 1 119 0
	movl	8(%edx), %edi
	movl	%edi, 8(%ebx)
.L12:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL19:
	testl	%eax, %eax
	je	.L13
	.loc 1 121 0
	movl	%ebx, 12(%eax)
.L13:
	.loc 1 122 0
	subl	$1, %esi
	movl	%esi, 8(%ecx)
	jmp	.L3
.LVL20:
	.p2align 4,,10
	.p2align 3
.L2:
.LBE63:
.LBE80:
	.loc 1 332 0
	movl	valid_queue, %ecx
.LVL21:
	.loc 1 331 0
	movl	$2, 4(%edx)
.LBB81:
.LBB82:
	.loc 1 90 0
	movl	8(%ecx), %esi
	.loc 1 89 0
	movl	(%ecx), %ebx
.LVL22:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L18
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L18
	.loc 1 93 0
	cmpl	%ebx, %edx
	je	.L19
	movl	%ebx, %eax
.LVL23:
	jmp	.L21
.LVL24:
	.p2align 4,,10
	.p2align 3
.L29:
	cmpl	%eax, %edx
	je	.L97
.L21:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL25:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L29
.LVL26:
.L18:
.LBE82:
.LBE81:
	.loc 1 333 0
	movl	zombie_queue, %ebx
.LVL27:
.LBB85:
.LBB86:
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	movl	8(%ebx), %eax
	testl	%eax, %eax
	jne	.L30
	.loc 1 46 0
	movl	%edx, (%ebx)
	.loc 1 47 0
	movl	%edx, 4(%ebx)
.L31:
	.loc 1 57 0
	addl	$1, %eax
	movl	%eax, 8(%ebx)
	jmp	.L17
.LVL28:
.L4:
.LBE86:
.LBE85:
.LBB88:
.LBB64:
	.loc 1 95 0
	cmpl	$1, %esi
	jne	.L40
.LVL29:
.L39:
	.loc 1 97 0
	movl	$0, (%ecx)
	.loc 1 98 0
	movl	$0, 4(%ecx)
	.loc 1 99 0
	movl	$0, 8(%ecx)
	jmp	.L3
.LVL30:
.L30:
.LBE64:
.LBE88:
.LBB89:
.LBB87:
	.loc 1 52 0
	movl	4(%ebx), %esi
	movl	%edx, 8(%esi)
	.loc 1 53 0
	movl	%esi, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%ebx)
	jmp	.L31
.LVL31:
.L97:
.LBE87:
.LBE89:
.LBB90:
.LBB83:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L41
	.loc 1 102 0
	cmpl	%edx, %ebx
	je	.L42
	.loc 1 110 0
	cmpl	%edx, 4(%ecx)
	je	.L98
	.loc 1 118 0
	movl	12(%edx), %ebx
	testl	%ebx, %ebx
	je	.L27
	.loc 1 119 0
	movl	8(%edx), %edi
	movl	%edi, 8(%ebx)
.L27:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL32:
	testl	%eax, %eax
	je	.L28
	.loc 1 121 0
	movl	%ebx, 12(%eax)
.L28:
	.loc 1 122 0
	subl	$1, %esi
	movl	%esi, 8(%ecx)
	jmp	.L18
.LVL33:
.L19:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L41
.LVL34:
.L42:
	.loc 1 104 0
	movl	8(%ebx), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ecx)
	.loc 1 105 0
	je	.L28
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L28
.LVL35:
.L40:
.LBE83:
.LBE90:
.LBB91:
.LBB65:
	.loc 1 104 0
	movl	8(%ebx), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ecx)
	.loc 1 105 0
	je	.L13
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L13
.LVL36:
.L96:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL37:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ecx)
	.loc 1 113 0
	je	.L13
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L13
.LVL38:
.L41:
.LBE65:
.LBE91:
.LBB92:
.LBB84:
	.loc 1 97 0
	movl	$0, (%ecx)
	.loc 1 98 0
	movl	$0, 4(%ecx)
	.loc 1 99 0
	movl	$0, 8(%ecx)
	jmp	.L18
.LVL39:
.L98:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL40:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ecx)
	.loc 1 113 0
	je	.L28
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L28
.LBE84:
.LBE92:
.LBE95:
.LBE98:
	.cfi_endproc
.LFE50:
	.size	__lwt_trampoline, .-__lwt_trampoline
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	__add_to_tail
	.type	__add_to_tail, @function
__add_to_tail:
.LFB38:
	.loc 1 40 0
	.cfi_startproc
.LVL41:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	.loc 1 40 0
	movl	12(%esp), %ecx
	movl	8(%esp), %edx
	.loc 1 44 0
	movl	8(%ecx), %eax
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	testl	%eax, %eax
	je	.L103
	.loc 1 52 0
	movl	4(%ecx), %ebx
	movl	%edx, 8(%ebx)
	.loc 1 53 0
	movl	%ebx, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%ecx)
	.loc 1 57 0
	leal	1(%eax), %edx
	movl	%edx, 8(%ecx)
	.loc 1 59 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
.LVL42:
	.p2align 4,,10
	.p2align 3
.L103:
	.cfi_restore_state
	.loc 1 46 0
	movl	%edx, (%ecx)
	.loc 1 47 0
	movl	%edx, 4(%ecx)
	.loc 1 57 0
	leal	1(%eax), %edx
.LVL43:
	movl	%edx, 8(%ecx)
	.loc 1 59 0
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE38:
	.size	__add_to_tail, .-__add_to_tail
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	__add_to_head
	.type	__add_to_head, @function
__add_to_head:
.LFB39:
	.loc 1 64 0
	.cfi_startproc
.LVL44:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	.loc 1 64 0
	movl	12(%esp), %ecx
	movl	8(%esp), %edx
	.loc 1 68 0
	movl	8(%ecx), %eax
	.loc 1 65 0
	movl	$0, 8(%edx)
	.loc 1 66 0
	movl	$0, 12(%edx)
	.loc 1 68 0
	testl	%eax, %eax
	je	.L108
	.loc 1 76 0
	movl	(%ecx), %ebx
	movl	%edx, 12(%ebx)
	.loc 1 77 0
	movl	%ebx, 8(%edx)
	.loc 1 78 0
	movl	%edx, (%ecx)
	.loc 1 81 0
	leal	1(%eax), %edx
	movl	%edx, 8(%ecx)
	.loc 1 83 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
.LVL45:
	.p2align 4,,10
	.p2align 3
.L108:
	.cfi_restore_state
	.loc 1 70 0
	movl	%edx, (%ecx)
	.loc 1 71 0
	movl	%edx, 4(%ecx)
	.loc 1 81 0
	leal	1(%eax), %edx
.LVL46:
	movl	%edx, 8(%ecx)
	.loc 1 83 0
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE39:
	.size	__add_to_head, .-__add_to_head
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	__remove_from_queue
	.type	__remove_from_queue, @function
__remove_from_queue:
.LFB40:
	.loc 1 88 0
	.cfi_startproc
.LVL47:
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	.loc 1 88 0
	movl	16(%esp), %ecx
	movl	12(%esp), %edx
	.loc 1 90 0
	movl	8(%ecx), %ebx
	.loc 1 89 0
	movl	(%ecx), %eax
.LVL48:
	.loc 1 90 0
	testl	%ebx, %ebx
	je	.L124
	.loc 1 91 0
	testl	%eax, %eax
	je	.L124
	.loc 1 93 0
	cmpl	%edx, %eax
	jne	.L113
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L120:
	cmpl	%eax, %edx
	je	.L146
.LVL49:
.L113:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL50:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L120
.L124:
	.loc 1 90 0
	movl	$-1, %eax
.LVL51:
.L141:
	.loc 1 131 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
.LVL52:
	.p2align 4,,10
	.p2align 3
.L146:
	.cfi_restore_state
	.loc 1 95 0
	cmpl	$1, %ebx
	je	.L121
	.loc 1 110 0
	cmpl	4(%ecx), %edx
	je	.L147
	.loc 1 118 0
	movl	12(%eax), %edx
.LVL53:
	testl	%edx, %edx
	je	.L118
	.loc 1 119 0
	movl	8(%eax), %esi
	movl	%esi, 8(%edx)
.L118:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL54:
	testl	%eax, %eax
	je	.L119
	.loc 1 121 0
	movl	%edx, 12(%eax)
.LVL55:
.L119:
	.loc 1 122 0
	subl	$1, %ebx
	.loc 1 123 0
	xorl	%eax, %eax
	.loc 1 122 0
	movl	%ebx, 8(%ecx)
	.loc 1 131 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
.LVL56:
.L121:
	.cfi_restore_state
	.loc 1 97 0
	movl	$0, (%ecx)
	.loc 1 98 0
	movl	$0, 4(%ecx)
	.loc 1 100 0
	xorl	%eax, %eax
.LVL57:
	.loc 1 99 0
	movl	$0, 8(%ecx)
	.loc 1 100 0
	jmp	.L141
.LVL58:
.L147:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL59:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ecx)
	.loc 1 113 0
	je	.L119
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L119
.LVL60:
.L145:
	.loc 1 95 0
	cmpl	$1, %ebx
	je	.L121
	.loc 1 104 0
	movl	8(%eax), %eax
.LVL61:
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ecx)
.LVL62:
	.loc 1 105 0
	je	.L119
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L119
	.cfi_endproc
.LFE40:
	.size	__remove_from_queue, .-__remove_from_queue
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	__get_active_thread
	.type	__get_active_thread, @function
__get_active_thread:
.LFB41:
	.loc 1 136 0
	.cfi_startproc
.LVL63:
	.loc 1 137 0
	movl	4(%esp), %eax
	movl	(%eax), %eax
.LVL64:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L153
	.loc 1 140 0
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L151
	jmp	.L156
	.p2align 4,,10
	.p2align 3
.L152:
	movl	4(%eax), %edx
	testl	%edx, %edx
	je	.L149
.L151:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL65:
	.loc 1 138 0
	testl	%eax, %eax
	jne	.L152
	rep ret
.L153:
	.loc 1 146 0
	xorl	%eax, %eax
.LVL66:
.L149:
	.loc 1 147 0
	rep ret
.LVL67:
.L156:
	rep ret
	.cfi_endproc
.LFE41:
	.size	__get_active_thread, .-__get_active_thread
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
	.globl	__lwt_dispatch
	.type	__lwt_dispatch, @function
__lwt_dispatch:
.LFB42:
	.loc 1 151 0
	.cfi_startproc
.LVL68:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE42:
	.size	__lwt_dispatch, .-__lwt_dispatch
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	__lwt_schedule
	.type	__lwt_schedule, @function
__lwt_schedule:
.LFB43:
	.loc 1 187 0
	.cfi_startproc
.LBB103:
.LBB104:
	.loc 1 137 0
	movl	valid_queue, %eax
.LBE104:
.LBE103:
	.loc 1 188 0
	movl	current_thread, %edx
.LBB107:
.LBB105:
	.loc 1 137 0
	movl	(%eax), %eax
.LBE105:
.LBE107:
	.loc 1 188 0
	movl	%edx, old_thread
.LVL69:
.LBB108:
.LBB106:
	.loc 1 138 0
	testl	%eax, %eax
	jne	.L163
	jmp	.L159
	.p2align 4,,10
	.p2align 3
.L169:
.LVL70:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL71:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L159
.LVL72:
.L163:
	.loc 1 140 0
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L169
.LVL73:
.LBE106:
.LBE108:
	.loc 1 190 0
	cmpl	%eax, %edx
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L170
.LVL74:
.LBB109:
.LBB110:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
#NO_APP
	ret
.LVL75:
	.p2align 4,,10
	.p2align 3
.L159:
.LBE110:
.LBE109:
	.loc 1 189 0
	movl	$0, current_thread
	ret
.L170:
	rep ret
	.cfi_endproc
.LFE43:
	.size	__lwt_schedule, .-__lwt_schedule
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4,,15
	.globl	__create_thread
	.type	__create_thread, @function
__create_thread:
.LFB44:
	.loc 1 208 0
	.cfi_startproc
.LVL76:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$20, %esp
	.cfi_def_cfa_offset 28
	.loc 1 209 0
	pushl	$40
	.cfi_def_cfa_offset 32
	call	malloc
.LVL77:
	movl	%eax, %ebx
.LVL78:
	.loc 1 210 0
	movl	lwt_counter, %eax
.LVL79:
	.loc 1 218 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 211 0
	movl	$0, 4(%ebx)
	.loc 1 212 0
	movl	$0, 8(%ebx)
	.loc 1 213 0
	movl	$0, 12(%ebx)
	.loc 1 214 0
	movl	$0, 16(%ebx)
	.loc 1 210 0
	leal	1(%eax), %edx
	movl	%eax, (%ebx)
	.loc 1 218 0
	movl	16(%esp), %eax
	.loc 1 215 0
	movl	$0, 20(%ebx)
	.loc 1 216 0
	movl	$0, 28(%ebx)
	.loc 1 210 0
	movl	%edx, lwt_counter
	.loc 1 218 0
	testl	%eax, %eax
	je	.L172
.LBB112:
	.loc 1 221 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$2097152
	.cfi_def_cfa_offset 32
	call	malloc
.LVL80:
	.loc 1 224 0
	movl	40(%esp), %edx
	.loc 1 222 0
	movl	%eax, 24(%ebx)
.LVL81:
	.loc 1 228 0
	addl	$2097140, %eax
.LVL82:
	.loc 1 229 0
	movl	$__lwt_trampoline, 32(%ebx)
	.loc 1 224 0
	movl	%edx, 8(%eax)
.LVL83:
	.loc 1 226 0
	movl	36(%esp), %edx
	.loc 1 229 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 226 0
	movl	%edx, 4(%eax)
	.loc 1 228 0
	movl	%eax, 36(%ebx)
.L172:
.LBE112:
	.loc 1 235 0
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	movl	%ebx, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL84:
	ret
	.cfi_endproc
.LFE44:
	.size	__create_thread, .-__create_thread
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.globl	__reuse_thread
	.type	__reuse_thread, @function
__reuse_thread:
.LFB45:
	.loc 1 240 0
	.cfi_startproc
.LVL85:
	.loc 1 241 0
	movl	recycle_queue, %edx
	.loc 1 240 0
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
.LBB115:
.LBB116:
	.loc 1 90 0
	movl	8(%edx), %ecx
.LBE116:
.LBE115:
	.loc 1 241 0
	movl	(%edx), %eax
.LVL86:
.LBB119:
.LBB117:
	.loc 1 91 0
	testl	%ecx, %ecx
	je	.L178
	testl	%eax, %eax
	je	.L178
	.loc 1 95 0
	cmpl	$1, %ecx
	je	.L191
	.loc 1 104 0
	movl	8(%eax), %ebx
	.loc 1 105 0
	testl	%ebx, %ebx
	.loc 1 104 0
	movl	%ebx, (%edx)
	.loc 1 105 0
	je	.L180
	.loc 1 106 0
	movl	$0, 12(%ebx)
.L180:
	.loc 1 107 0
	subl	$1, %ecx
	movl	%ecx, 8(%edx)
.L178:
.LVL87:
.LBE117:
.LBE119:
	.loc 1 243 0
	movl	lwt_counter, %edx
	.loc 1 244 0
	movl	$0, 4(%eax)
	.loc 1 245 0
	movl	$0, 8(%eax)
	.loc 1 246 0
	movl	$0, 12(%eax)
	.loc 1 247 0
	movl	$0, 16(%eax)
	.loc 1 248 0
	movl	$0, 20(%eax)
	.loc 1 243 0
	leal	1(%edx), %ecx
	.loc 1 249 0
	movl	$0, 28(%eax)
	.loc 1 243 0
	movl	%ecx, lwt_counter
	movl	%edx, (%eax)
	.loc 1 255 0
	movl	12(%esp), %ecx
	.loc 1 253 0
	movl	24(%eax), %edx
.LVL88:
	.loc 1 255 0
	movl	%ecx, 2097148(%edx)
.LVL89:
	.loc 1 257 0
	movl	8(%esp), %ecx
	.loc 1 259 0
	addl	$2097140, %edx
.LVL90:
	.loc 1 257 0
	movl	%ecx, 4(%edx)
.LVL91:
	.loc 1 259 0
	movl	%edx, 36(%eax)
	.loc 1 260 0
	movl	$__lwt_trampoline, 32(%eax)
	.loc 1 262 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
.LVL92:
.L191:
	.cfi_restore_state
.LBB120:
.LBB118:
	.loc 1 97 0
	movl	$0, (%edx)
	.loc 1 98 0
	movl	$0, 4(%edx)
	.loc 1 99 0
	movl	$0, 8(%edx)
	jmp	.L178
.LBE118:
.LBE120:
	.cfi_endproc
.LFE45:
	.size	__reuse_thread, .-__reuse_thread
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	__init_list
	.type	__init_list, @function
__init_list:
.LFB47:
	.loc 1 283 0
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	.loc 1 284 0
	pushl	$12
	.cfi_def_cfa_offset 32
	call	malloc
.LVL93:
	.loc 1 285 0
	movl	$0, 8(%eax)
	.loc 1 286 0
	movl	$0, (%eax)
	.loc 1 287 0
	movl	$0, 4(%eax)
	.loc 1 289 0
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE47:
	.size	__init_list, .-__init_list
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	lwt_create
	.type	lwt_create, @function
lwt_create:
.LFB48:
	.loc 1 294 0
	.cfi_startproc
.LVL94:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 295 0
	movl	thread_initiated, %ebx
	testl	%ebx, %ebx
	je	.L223
	.loc 1 298 0
	movl	recycle_queue, %eax
	movl	8(%eax), %edx
	testl	%edx, %edx
	je	.L224
.LVL95:
.LBB149:
.LBB150:
	.loc 1 241 0
	movl	(%eax), %ebx
.LVL96:
.LBB151:
.LBB152:
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L198
	.loc 1 95 0
	cmpl	$1, %edx
	je	.L225
	.loc 1 104 0
	movl	8(%ebx), %ecx
	.loc 1 105 0
	testl	%ecx, %ecx
	.loc 1 104 0
	movl	%ecx, (%eax)
	.loc 1 105 0
	je	.L199
	.loc 1 106 0
	movl	$0, 12(%ecx)
.L199:
	.loc 1 107 0
	subl	$1, %edx
	movl	%edx, 8(%eax)
.L198:
.LVL97:
.LBE152:
.LBE151:
	.loc 1 243 0
	movl	lwt_counter, %eax
	.loc 1 255 0
	movl	20(%esp), %ecx
	.loc 1 244 0
	movl	$0, 4(%ebx)
	.loc 1 245 0
	movl	$0, 8(%ebx)
	.loc 1 246 0
	movl	$0, 12(%ebx)
	.loc 1 247 0
	movl	$0, 16(%ebx)
	.loc 1 243 0
	leal	1(%eax), %edx
	.loc 1 248 0
	movl	$0, 20(%ebx)
	.loc 1 249 0
	movl	$0, 28(%ebx)
	movl	valid_queue, %edi
	.loc 1 243 0
	movl	%edx, lwt_counter
	movl	%eax, (%ebx)
	.loc 1 253 0
	movl	24(%ebx), %eax
.LVL98:
	.loc 1 255 0
	movl	%ecx, 2097148(%eax)
.LVL99:
	.loc 1 257 0
	movl	16(%esp), %ecx
	.loc 1 259 0
	addl	$2097140, %eax
.LVL100:
	.loc 1 257 0
	movl	%ecx, 4(%eax)
.LVL101:
	.loc 1 259 0
	movl	%eax, 36(%ebx)
	.loc 1 260 0
	movl	$__lwt_trampoline, 32(%ebx)
.LVL102:
.LBE150:
.LBE149:
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L224:
	movl	lwt_counter, %esi
	movl	valid_queue, %edi
.L196:
.LVL103:
.LBB156:
.LBB157:
	.loc 1 209 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$40
	.cfi_def_cfa_offset 32
	call	malloc
.LVL104:
	movl	%eax, %ebx
.LVL105:
	.loc 1 210 0
	leal	1(%esi), %eax
.LVL106:
	movl	%esi, (%ebx)
	.loc 1 211 0
	movl	$0, 4(%ebx)
	.loc 1 212 0
	movl	$0, 8(%ebx)
	.loc 1 213 0
	movl	$0, 12(%ebx)
	.loc 1 214 0
	movl	$0, 16(%ebx)
	.loc 1 215 0
	movl	$0, 20(%ebx)
	.loc 1 216 0
	movl	$0, 28(%ebx)
	.loc 1 210 0
	movl	%eax, lwt_counter
.LBB158:
	.loc 1 221 0
	movl	$2097152, (%esp)
	call	malloc
.LVL107:
	.loc 1 224 0
	movl	36(%esp), %esi
	.loc 1 226 0
	movl	32(%esp), %ecx
	.loc 1 229 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 222 0
	movl	%eax, 24(%ebx)
.LVL108:
	.loc 1 228 0
	addl	$2097140, %eax
.LVL109:
	.loc 1 229 0
	movl	$__lwt_trampoline, 32(%ebx)
	.loc 1 224 0
	movl	%esi, 8(%eax)
.LVL110:
	.loc 1 226 0
	movl	%ecx, 4(%eax)
.LVL111:
	.loc 1 228 0
	movl	%eax, 36(%ebx)
.L200:
.LVL112:
.LBE158:
.LBE157:
.LBE156:
.LBB159:
.LBB160:
	.loc 1 44 0 discriminator 4
	movl	8(%edi), %edx
	.loc 1 41 0 discriminator 4
	movl	$0, 8(%ebx)
	.loc 1 42 0 discriminator 4
	movl	$0, 12(%ebx)
	.loc 1 44 0 discriminator 4
	testl	%edx, %edx
	je	.L226
	.loc 1 52 0
	movl	4(%edi), %eax
	.loc 1 57 0
	addl	$1, %edx
	.loc 1 52 0
	movl	%ebx, 8(%eax)
	.loc 1 53 0
	movl	%eax, 12(%ebx)
	movl	(%edi), %eax
	.loc 1 57 0
	movl	%edx, 8(%edi)
.LVL113:
.LBE160:
.LBE159:
.LBB164:
.LBB165:
	.loc 1 188 0
	movl	current_thread, %edx
.LBE165:
.LBE164:
.LBB177:
.LBB161:
	.loc 1 54 0
	movl	%ebx, 4(%edi)
.LBE161:
.LBE177:
.LBB178:
.LBB172:
.LBB166:
.LBB167:
	.loc 1 138 0
	testl	%eax, %eax
.LBE167:
.LBE166:
	.loc 1 188 0
	movl	%edx, old_thread
.LVL114:
.LBB169:
.LBB168:
	.loc 1 138 0
	jne	.L207
	jmp	.L203
.LVL115:
	.p2align 4,,10
	.p2align 3
.L227:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL116:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L203
.LVL117:
.L207:
	.loc 1 140 0
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L227
.LVL118:
.LBE168:
.LBE169:
	.loc 1 190 0
	cmpl	%edx, %eax
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L219
.LVL119:
.LBB170:
.LBB171:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
.LVL120:
#NO_APP
.L219:
.LBE171:
.LBE170:
.LBE172:
.LBE178:
	.loc 1 305 0
	movl	%ebx, %eax
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
.LVL121:
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL122:
	.p2align 4,,10
	.p2align 3
.L203:
	.cfi_restore_state
	movl	%ebx, %eax
.LBB179:
.LBB173:
	.loc 1 189 0
	movl	$0, current_thread
.LBE173:
.LBE179:
	.loc 1 305 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
.LVL123:
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL124:
	.p2align 4,,10
	.p2align 3
.L226:
	.cfi_restore_state
.LBB180:
.LBB174:
	.loc 1 188 0
	movl	current_thread, %edx
.LBE174:
.LBE180:
.LBB181:
.LBB162:
	.loc 1 46 0
	movl	%ebx, (%edi)
.LBE162:
.LBE181:
.LBB182:
.LBB175:
	.loc 1 188 0
	movl	%ebx, %eax
.LBE175:
.LBE182:
.LBB183:
.LBB163:
	.loc 1 47 0
	movl	%ebx, 4(%edi)
	.loc 1 57 0
	movl	$1, 8(%edi)
.LVL125:
.LBE163:
.LBE183:
.LBB184:
.LBB176:
	.loc 1 188 0
	movl	%edx, old_thread
.LVL126:
	jmp	.L207
.LVL127:
	.p2align 4,,10
	.p2align 3
.L223:
.LBE176:
.LBE184:
.LBB185:
.LBB186:
.LBB187:
.LBB188:
	.loc 1 209 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
.LBE188:
.LBE187:
	.loc 1 268 0
	movl	$1, thread_initiated
.LVL128:
.LBB190:
.LBB189:
	.loc 1 209 0
	pushl	$40
	.cfi_def_cfa_offset 32
	call	malloc
.LVL129:
	movl	%eax, %ebx
.LVL130:
	.loc 1 210 0
	movl	lwt_counter, %eax
.LVL131:
	.loc 1 211 0
	movl	$0, 4(%ebx)
	.loc 1 212 0
	movl	$0, 8(%ebx)
	.loc 1 213 0
	movl	$0, 12(%ebx)
	.loc 1 214 0
	movl	$0, 16(%ebx)
	.loc 1 210 0
	movl	%eax, (%ebx)
	.loc 1 215 0
	movl	$0, 20(%ebx)
	.loc 1 210 0
	leal	1(%eax), %esi
	.loc 1 216 0
	movl	$0, 28(%ebx)
.LVL132:
.LBE189:
.LBE190:
	.loc 1 269 0
	movl	%ebx, current_thread
.LBB191:
.LBB192:
	.loc 1 284 0
	movl	$12, (%esp)
	call	malloc
.LVL133:
.LBE192:
.LBE191:
.LBB194:
.LBB195:
	movl	$12, (%esp)
.LBE195:
.LBE194:
.LBB197:
.LBB193:
	movl	%eax, %edi
.LBE193:
.LBE197:
	.loc 1 271 0
	movl	%eax, valid_queue
.LBB198:
.LBB196:
	.loc 1 284 0
	call	malloc
.LVL134:
	.loc 1 285 0
	movl	$0, 8(%eax)
	.loc 1 286 0
	movl	$0, (%eax)
	.loc 1 287 0
	movl	$0, 4(%eax)
.LVL135:
.LBE196:
.LBE198:
	.loc 1 273 0
	movl	%eax, recycle_queue
.LBB199:
.LBB200:
	.loc 1 284 0
	movl	$12, (%esp)
	call	malloc
.LVL136:
.LBE200:
.LBE199:
.LBB203:
.LBB204:
	.loc 1 46 0
	movl	%ebx, (%edi)
.LBE204:
.LBE203:
.LBB207:
.LBB201:
	.loc 1 285 0
	movl	$0, 8(%eax)
.LBE201:
.LBE207:
.LBB208:
.LBB205:
	.loc 1 57 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.LBE205:
.LBE208:
.LBB209:
.LBB202:
	.loc 1 286 0
	movl	$0, (%eax)
	.loc 1 287 0
	movl	$0, 4(%eax)
.LVL137:
.LBE202:
.LBE209:
	.loc 1 275 0
	movl	%eax, zombie_queue
.LVL138:
.LBB210:
.LBB206:
	.loc 1 47 0
	movl	%ebx, 4(%edi)
	.loc 1 57 0
	movl	$1, 8(%edi)
.LVL139:
	jmp	.L196
.LVL140:
.L225:
.LBE206:
.LBE210:
.LBE186:
.LBE185:
.LBB211:
.LBB155:
.LBB154:
.LBB153:
	.loc 1 97 0
	movl	$0, (%eax)
	.loc 1 98 0
	movl	$0, 4(%eax)
	.loc 1 99 0
	movl	$0, 8(%eax)
	jmp	.L198
.LBE153:
.LBE154:
.LBE155:
.LBE211:
	.cfi_endproc
.LFE48:
	.size	lwt_create, .-lwt_create
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	lwt_die
	.type	lwt_die, @function
lwt_die:
.LFB49:
	.loc 1 310 0
	.cfi_startproc
.LVL141:
	.loc 1 314 0
	movl	current_thread, %edx
	.loc 1 310 0
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 310 0
	movl	16(%esp), %ecx
	.loc 1 316 0
	movl	16(%edx), %eax
	.loc 1 314 0
	movl	%ecx, 28(%edx)
	.loc 1 316 0
	testl	%eax, %eax
	je	.L229
	.loc 1 319 0
	movl	%ecx, 28(%eax)
	.loc 1 322 0
	movl	valid_queue, %ecx
.LVL142:
	.loc 1 318 0
	movl	$0, 4(%eax)
	.loc 1 320 0
	movl	$0, 16(%edx)
	.loc 1 321 0
	movl	$2, 4(%edx)
.LBB226:
.LBB227:
	.loc 1 90 0
	movl	8(%ecx), %esi
	.loc 1 89 0
	movl	(%ecx), %ebx
.LVL143:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L230
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L230
	.loc 1 93 0
	cmpl	%ebx, %edx
	je	.L231
	movl	%ebx, %eax
	jmp	.L233
.LVL144:
	.p2align 4,,10
	.p2align 3
.L241:
	cmpl	%eax, %edx
	je	.L318
.L233:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL145:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L241
.LVL146:
.L230:
.LBE227:
.LBE226:
	.loc 1 323 0
	movl	recycle_queue, %eax
.LVL147:
.LBB231:
.LBB232:
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	movl	8(%eax), %ebx
	testl	%ebx, %ebx
	je	.L319
	.loc 1 52 0
	movl	4(%eax), %esi
	movl	%edx, 8(%esi)
	.loc 1 53 0
	movl	%esi, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%eax)
.L243:
	.loc 1 57 0
	addl	$1, %ebx
	movl	%ebx, 8(%eax)
.LVL148:
.L244:
.LBE232:
.LBE231:
.LBB234:
.LBB235:
.LBB236:
.LBB237:
	.loc 1 137 0
	movl	(%ecx), %eax
.LBE237:
.LBE236:
	.loc 1 188 0
	movl	%edx, old_thread
.LVL149:
.LBB239:
.LBB238:
	.loc 1 138 0
	testl	%eax, %eax
	jne	.L263
	jmp	.L259
.LVL150:
	.p2align 4,,10
	.p2align 3
.L320:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL151:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L259
.LVL152:
.L263:
	.loc 1 140 0
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L320
.LVL153:
.LBE238:
.LBE239:
	.loc 1 190 0
	cmpl	%eax, %edx
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L228
.LVL154:
.LBB240:
.LBB241:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
#NO_APP
.L228:
.LBE241:
.LBE240:
.LBE235:
.LBE234:
	.loc 1 341 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL155:
	.p2align 4,,10
	.p2align 3
.L319:
	.cfi_restore_state
.LBB243:
.LBB233:
	.loc 1 46 0
	movl	%edx, (%eax)
	.loc 1 47 0
	movl	%edx, 4(%eax)
	jmp	.L243
.LVL156:
	.p2align 4,,10
	.p2align 3
.L259:
.LBE233:
.LBE243:
	.loc 1 341 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
.LBB244:
.LBB242:
	.loc 1 189 0
	movl	$0, current_thread
.LBE242:
.LBE244:
	.loc 1 341 0
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL157:
	.p2align 4,,10
	.p2align 3
.L318:
	.cfi_restore_state
.LBB245:
.LBB228:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L266
	.loc 1 102 0
	cmpl	%edx, %ebx
	je	.L267
	.loc 1 110 0
	cmpl	%edx, 4(%ecx)
	je	.L321
	.loc 1 118 0
	movl	12(%edx), %ebx
	testl	%ebx, %ebx
	je	.L239
	.loc 1 119 0
	movl	8(%edx), %edi
	movl	%edi, 8(%ebx)
.L239:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL158:
	testl	%eax, %eax
	je	.L240
	.loc 1 121 0
	movl	%ebx, 12(%eax)
.L240:
	.loc 1 122 0
	subl	$1, %esi
	movl	%esi, 8(%ecx)
	jmp	.L230
.LVL159:
	.p2align 4,,10
	.p2align 3
.L229:
.LBE228:
.LBE245:
	.loc 1 332 0
	movl	valid_queue, %ecx
.LVL160:
	.loc 1 331 0
	movl	$2, 4(%edx)
.LBB246:
.LBB247:
	.loc 1 90 0
	movl	8(%ecx), %esi
	.loc 1 89 0
	movl	(%ecx), %ebx
.LVL161:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L245
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L245
	.loc 1 93 0
	cmpl	%ebx, %edx
	je	.L246
	movl	%ebx, %eax
	jmp	.L248
.LVL162:
	.p2align 4,,10
	.p2align 3
.L256:
	cmpl	%eax, %edx
	je	.L322
.L248:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL163:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L256
.LVL164:
.L245:
.LBE247:
.LBE246:
	.loc 1 333 0
	movl	zombie_queue, %ebx
.LVL165:
.LBB250:
.LBB251:
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	movl	8(%ebx), %eax
	testl	%eax, %eax
	jne	.L257
	.loc 1 46 0
	movl	%edx, (%ebx)
	.loc 1 47 0
	movl	%edx, 4(%ebx)
.L258:
	.loc 1 57 0
	addl	$1, %eax
	movl	%eax, 8(%ebx)
	jmp	.L244
.LVL166:
.L231:
.LBE251:
.LBE250:
.LBB253:
.LBB229:
	.loc 1 95 0
	cmpl	$1, %esi
	jne	.L267
.LVL167:
.L266:
	.loc 1 97 0
	movl	$0, (%ecx)
	.loc 1 98 0
	movl	$0, 4(%ecx)
	.loc 1 99 0
	movl	$0, 8(%ecx)
	jmp	.L230
.LVL168:
.L257:
.LBE229:
.LBE253:
.LBB254:
.LBB252:
	.loc 1 52 0
	movl	4(%ebx), %esi
	movl	%edx, 8(%esi)
	.loc 1 53 0
	movl	%esi, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%ebx)
	jmp	.L258
.LVL169:
.L322:
.LBE252:
.LBE254:
.LBB255:
.LBB248:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L268
	.loc 1 102 0
	cmpl	%edx, %ebx
	je	.L269
	.loc 1 110 0
	cmpl	%edx, 4(%ecx)
	je	.L323
	.loc 1 118 0
	movl	12(%edx), %ebx
	testl	%ebx, %ebx
	je	.L254
	.loc 1 119 0
	movl	8(%edx), %edi
	movl	%edi, 8(%ebx)
.L254:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL170:
	testl	%eax, %eax
	je	.L255
	.loc 1 121 0
	movl	%ebx, 12(%eax)
.L255:
	.loc 1 122 0
	subl	$1, %esi
	movl	%esi, 8(%ecx)
	jmp	.L245
.LVL171:
.L246:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L268
.LVL172:
.L269:
	.loc 1 104 0
	movl	8(%ebx), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ecx)
	.loc 1 105 0
	je	.L255
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L255
.LVL173:
.L267:
.LBE248:
.LBE255:
.LBB256:
.LBB230:
	.loc 1 104 0
	movl	8(%ebx), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ecx)
	.loc 1 105 0
	je	.L240
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L240
.LVL174:
.L321:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL175:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ecx)
	.loc 1 113 0
	je	.L240
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L240
.LVL176:
.L268:
.LBE230:
.LBE256:
.LBB257:
.LBB249:
	.loc 1 97 0
	movl	$0, (%ecx)
	.loc 1 98 0
	movl	$0, 4(%ecx)
	.loc 1 99 0
	movl	$0, 8(%ecx)
	jmp	.L245
.LVL177:
.L323:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL178:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ecx)
	.loc 1 113 0
	je	.L255
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L255
.LBE249:
.LBE257:
	.cfi_endproc
.LFE49:
	.size	lwt_die, .-lwt_die
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.p2align 4,,15
	.globl	lwt_yield
	.type	lwt_yield, @function
lwt_yield:
.LFB51:
	.loc 1 357 0
	.cfi_startproc
.LVL179:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$4, %esp
	.cfi_def_cfa_offset 24
	.loc 1 357 0
	movl	24(%esp), %eax
	.loc 1 359 0
	testl	%eax, %eax
	je	.L474
	.loc 1 371 0
	movl	current_thread, %ecx
	cmpl	%ecx, %eax
	je	.L415
	.loc 1 379 0
	movl	4(%eax), %esi
	testl	%esi, %esi
	je	.L475
.L415:
	.loc 1 392 0
	addl	$4, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	xorl	%eax, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
	.p2align 3
.L475:
	.cfi_restore_state
	.loc 1 386 0
	movl	valid_queue, %esi
.LVL180:
.LBB282:
.LBB283:
	.loc 1 90 0
	movl	8(%esi), %edi
	.loc 1 89 0
	movl	(%esi), %ebx
.LVL181:
	.loc 1 90 0
	testl	%edi, %edi
	je	.L350
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L470
	.loc 1 93 0
	cmpl	%ecx, %ebx
	je	.L353
	movl	%ebx, %edx
	jmp	.L355
.LVL182:
	.p2align 4,,10
	.p2align 3
.L363:
	cmpl	%edx, %ecx
	je	.L476
.L355:
	.loc 1 125 0
	movl	8(%edx), %edx
.LVL183:
	.loc 1 91 0
	testl	%edx, %edx
	jne	.L363
.LVL184:
.L470:
	addl	$1, %edi
.LVL185:
.LBE283:
.LBE282:
.LBB288:
.LBB289:
	.loc 1 41 0
	movl	$0, 8(%ecx)
.L364:
	.loc 1 52 0
	movl	4(%esi), %edx
	movl	%ecx, 8(%edx)
	.loc 1 53 0
	movl	%edx, 12(%ecx)
	.loc 1 54 0
	movl	%ecx, 4(%esi)
.L365:
.LBE289:
.LBE288:
.LBB294:
.LBB295:
	.loc 1 90 0
	testl	%edi, %edi
.LBE295:
.LBE294:
.LBB302:
.LBB290:
	.loc 1 57 0
	movl	%edi, 8(%esi)
.LVL186:
.LBE290:
.LBE302:
.LBB303:
.LBB296:
	.loc 1 90 0
	je	.L366
	.loc 1 91 0
	testl	%ebx, %ebx
	je	.L471
	.loc 1 93 0
	cmpl	%ebx, %eax
	je	.L369
	movl	%ebx, %edx
	jmp	.L371
.LVL187:
	.p2align 4,,10
	.p2align 3
.L379:
	cmpl	%edx, %eax
	je	.L477
.LVL188:
.L371:
	.loc 1 125 0
	movl	8(%edx), %edx
.LVL189:
	.loc 1 91 0
	testl	%edx, %edx
	jne	.L379
.LVL190:
.L471:
	addl	$1, %edi
.LVL191:
.LBE296:
.LBE303:
.LBB304:
.LBB305:
	.loc 1 66 0
	movl	$0, 12(%eax)
.L380:
	.loc 1 76 0
	movl	%eax, 12(%ebx)
	.loc 1 77 0
	movl	%ebx, 8(%eax)
	.loc 1 78 0
	movl	%eax, (%esi)
.L381:
.LBE305:
.LBE304:
.LBB310:
.LBB311:
.LBB312:
.LBB313:
	.loc 1 140 0
	movl	4(%eax), %edx
.LBE313:
.LBE312:
.LBE311:
.LBE310:
.LBB320:
.LBB306:
	.loc 1 81 0
	movl	%edi, 8(%esi)
.LVL192:
.LBE306:
.LBE320:
.LBB321:
.LBB318:
	.loc 1 188 0
	movl	%ecx, old_thread
.LVL193:
.LBB315:
.LBB314:
	.loc 1 140 0
	testl	%edx, %edx
	je	.L382
	movl	%ebx, %eax
	jmp	.L392
.LVL194:
	.p2align 4,,10
	.p2align 3
.L383:
	movl	4(%eax), %ebx
	testl	%ebx, %ebx
	je	.L382
	movl	8(%eax), %eax
.L392:
	.loc 1 138 0
	testl	%eax, %eax
	jne	.L383
.LVL195:
.L342:
.LBE314:
.LBE315:
.LBE318:
.LBE321:
.LBB322:
.LBB323:
	.loc 1 189 0
	movl	$0, current_thread
.LBE323:
.LBE322:
	.loc 1 392 0
	addl	$4, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	xorl	%eax, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
.LVL196:
	.p2align 4,,10
	.p2align 3
.L382:
	.cfi_restore_state
.LBB330:
.LBB319:
	.loc 1 190 0
	cmpl	%ecx, %eax
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L415
.L385:
.LVL197:
.LBB316:
.LBB317:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
#NO_APP
.LBE317:
.LBE316:
.LBE319:
.LBE330:
	.loc 1 392 0
	addl	$4, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	xorl	%eax, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
.LVL198:
	.p2align 4,,10
	.p2align 3
.L477:
	.cfi_restore_state
.LBB331:
.LBB297:
	.loc 1 95 0
	cmpl	$1, %edi
	movl	%edx, (%esp)
	je	.L366
	.loc 1 102 0
	cmpl	%ebx, %eax
	je	.L388
	.loc 1 110 0
	cmpl	%eax, 4(%esi)
	je	.L478
	.loc 1 118 0
	movl	12(%eax), %ebp
	testl	%ebp, %ebp
	je	.L377
	.loc 1 119 0
	movl	8(%eax), %edx
.LVL199:
	movl	%edx, 8(%ebp)
	movl	(%esp), %edx
.LVL200:
.L377:
	.loc 1 120 0
	movl	8(%edx), %edx
.LVL201:
	testl	%edx, %edx
	je	.L378
	.loc 1 121 0
	movl	%ebp, 12(%edx)
.LVL202:
.L378:
	.loc 1 122 0
	leal	-1(%edi), %edx
.LBE297:
.LBE331:
.LBB332:
.LBB307:
	.loc 1 68 0
	testl	%edx, %edx
.LBE307:
.LBE332:
.LBB333:
.LBB298:
	.loc 1 122 0
	movl	%edx, 8(%esi)
.LVL203:
.LBE298:
.LBE333:
.LBB334:
.LBB308:
	.loc 1 65 0
	movl	$0, 8(%eax)
	.loc 1 66 0
	movl	$0, 12(%eax)
	.loc 1 68 0
	jne	.L380
.L391:
	.loc 1 70 0
	movl	%eax, (%esi)
	.loc 1 71 0
	movl	%eax, 4(%esi)
	xorl	%ebx, %ebx
	jmp	.L381
.LVL204:
	.p2align 4,,10
	.p2align 3
.L476:
.LBE308:
.LBE334:
.LBB335:
.LBB284:
	.loc 1 95 0
	cmpl	$1, %edi
	je	.L350
	.loc 1 102 0
	cmpl	%ecx, %ebx
	je	.L387
	.loc 1 110 0
	cmpl	%ecx, 4(%esi)
	je	.L479
	.loc 1 118 0
	movl	12(%ecx), %ebx
	testl	%ebx, %ebx
	je	.L361
	.loc 1 119 0
	movl	8(%ecx), %ebp
	movl	%ebp, 8(%ebx)
.L361:
	.loc 1 120 0
	movl	8(%edx), %edx
.LVL205:
	testl	%edx, %edx
	je	.L362
	.loc 1 121 0
	movl	%ebx, 12(%edx)
.L362:
	.loc 1 122 0
	leal	-1(%edi), %edx
.LBE284:
.LBE335:
.LBB336:
.LBB291:
	.loc 1 44 0
	testl	%edx, %edx
.LBE291:
.LBE336:
.LBB337:
.LBB285:
	.loc 1 122 0
	movl	%edx, 8(%esi)
.LVL206:
.LBE285:
.LBE337:
.LBB338:
.LBB292:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	.loc 1 44 0
	jne	.L480
.L390:
	.loc 1 46 0
	movl	%ecx, (%esi)
	.loc 1 47 0
	movl	%ecx, 4(%esi)
	movl	%ecx, %ebx
	jmp	.L365
.LVL207:
	.p2align 4,,10
	.p2align 3
.L474:
.LBE292:
.LBE338:
	.loc 1 364 0
	movl	valid_queue, %ebx
	movl	current_thread, %ecx
.LVL208:
.LBB339:
.LBB340:
	.loc 1 90 0
	movl	8(%ebx), %esi
	.loc 1 89 0
	movl	(%ebx), %eax
.LVL209:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L326
	.loc 1 91 0
	testl	%eax, %eax
	je	.L469
	.loc 1 93 0
	cmpl	%eax, %ecx
	je	.L329
	movl	%eax, %edx
	jmp	.L331
.LVL210:
	.p2align 4,,10
	.p2align 3
.L339:
	cmpl	%edx, %ecx
	je	.L481
.L331:
	.loc 1 125 0
	movl	8(%edx), %edx
.LVL211:
	.loc 1 91 0
	testl	%edx, %edx
	jne	.L339
.LVL212:
.L469:
	addl	$1, %esi
.LVL213:
.LBE340:
.LBE339:
.LBB345:
.LBB346:
	.loc 1 41 0
	movl	$0, 8(%ecx)
.L340:
	.loc 1 52 0
	movl	4(%ebx), %edx
	movl	%ecx, 8(%edx)
	.loc 1 53 0
	movl	%edx, 12(%ecx)
	.loc 1 54 0
	movl	%ecx, 4(%ebx)
.L341:
.LBE346:
.LBE345:
.LBB351:
.LBB328:
.LBB324:
.LBB325:
	.loc 1 138 0
	testl	%eax, %eax
.LBE325:
.LBE324:
.LBE328:
.LBE351:
.LBB352:
.LBB347:
	.loc 1 57 0
	movl	%esi, 8(%ebx)
.LVL214:
.LBE347:
.LBE352:
.LBB353:
.LBB329:
	.loc 1 188 0
	movl	%ecx, old_thread
.LVL215:
.LBB327:
.LBB326:
	.loc 1 138 0
	jne	.L346
	jmp	.L342
.LVL216:
	.p2align 4,,10
	.p2align 3
.L482:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL217:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L342
.LVL218:
.L346:
	.loc 1 140 0
	movl	4(%eax), %edi
	testl	%edi, %edi
	jne	.L482
.LVL219:
.LBE326:
.LBE327:
	.loc 1 190 0
	cmpl	%eax, %ecx
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	jne	.L385
	jmp	.L415
.LVL220:
.L369:
.LBE329:
.LBE353:
.LBB354:
.LBB299:
	.loc 1 95 0
	cmpl	$1, %edi
	jne	.L388
.LVL221:
	.p2align 4,,10
	.p2align 3
.L366:
.LBE299:
.LBE354:
.LBB355:
.LBB309:
	.loc 1 65 0
	movl	$0, 8(%eax)
	.loc 1 66 0
	movl	$0, 12(%eax)
	movl	$1, %edi
	jmp	.L391
.LVL222:
.L353:
.LBE309:
.LBE355:
.LBB356:
.LBB286:
	.loc 1 95 0
	cmpl	$1, %edi
	jne	.L387
.LVL223:
	.p2align 4,,10
	.p2align 3
.L350:
.LBE286:
.LBE356:
.LBB357:
.LBB293:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	movl	$1, %edi
	jmp	.L390
.LVL224:
.L481:
.LBE293:
.LBE357:
.LBB358:
.LBB341:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L326
	.loc 1 102 0
	cmpl	%ecx, %eax
	je	.L386
	.loc 1 110 0
	cmpl	%ecx, 4(%ebx)
	.loc 1 112 0
	movl	12(%ecx), %eax
	.loc 1 110 0
	je	.L483
	.loc 1 118 0
	testl	%eax, %eax
	je	.L337
	.loc 1 119 0
	movl	8(%ecx), %edi
	movl	%edi, 8(%eax)
.L337:
	.loc 1 120 0
	movl	8(%edx), %edx
.LVL225:
	testl	%edx, %edx
	je	.L338
	.loc 1 121 0
	movl	%eax, 12(%edx)
.L338:
	.loc 1 122 0
	leal	-1(%esi), %eax
.LBE341:
.LBE358:
.LBB359:
.LBB348:
	.loc 1 44 0
	testl	%eax, %eax
.LBE348:
.LBE359:
.LBB360:
.LBB342:
	.loc 1 122 0
	movl	%eax, 8(%ebx)
.LVL226:
.LBE342:
.LBE360:
.LBB361:
.LBB349:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	.loc 1 44 0
	jne	.L484
.L389:
	.loc 1 46 0
	movl	%ecx, (%ebx)
	.loc 1 47 0
	movl	%ecx, 4(%ebx)
.LBE349:
.LBE361:
	.loc 1 364 0
	movl	%ecx, %eax
	jmp	.L341
.LVL227:
.L388:
.LBB362:
.LBB300:
	.loc 1 104 0
	movl	8(%ebx), %ebx
	.loc 1 105 0
	testl	%ebx, %ebx
	.loc 1 104 0
	movl	%ebx, (%esi)
	.loc 1 105 0
	je	.L378
	.loc 1 106 0
	movl	$0, 12(%ebx)
	jmp	.L378
.LVL228:
.L387:
.LBE300:
.LBE362:
.LBB363:
.LBB287:
	.loc 1 104 0
	movl	8(%ebx), %edx
	.loc 1 105 0
	testl	%edx, %edx
	.loc 1 104 0
	movl	%edx, (%esi)
	.loc 1 105 0
	je	.L362
	.loc 1 106 0
	movl	$0, 12(%edx)
	jmp	.L362
.LVL229:
.L479:
	.loc 1 112 0
	movl	12(%ecx), %edx
.LVL230:
	.loc 1 113 0
	testl	%edx, %edx
	.loc 1 112 0
	movl	%edx, 4(%esi)
	.loc 1 113 0
	je	.L362
	.loc 1 114 0
	movl	$0, 8(%edx)
	jmp	.L362
.LVL231:
.L478:
.LBE287:
.LBE363:
.LBB364:
.LBB301:
	.loc 1 112 0
	movl	12(%eax), %edx
.LVL232:
	.loc 1 113 0
	testl	%edx, %edx
	.loc 1 112 0
	movl	%edx, 4(%esi)
	.loc 1 113 0
	je	.L378
	.loc 1 114 0
	movl	$0, 8(%edx)
	jmp	.L378
.LVL233:
.L329:
.LBE301:
.LBE364:
.LBB365:
.LBB343:
	.loc 1 95 0
	cmpl	$1, %esi
	jne	.L386
.LVL234:
.L326:
.LBE343:
.LBE365:
.LBB366:
.LBB350:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	movl	$1, %esi
	jmp	.L389
.LVL235:
.L386:
.LBE350:
.LBE366:
.LBB367:
.LBB344:
	.loc 1 104 0
	movl	8(%eax), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ebx)
	.loc 1 105 0
	je	.L338
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L338
.LVL236:
.L483:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ebx)
	.loc 1 113 0
	je	.L338
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L338
.LVL237:
.L480:
	movl	(%esi), %ebx
	jmp	.L364
.LVL238:
.L484:
	movl	(%ebx), %eax
	jmp	.L340
.LBE344:
.LBE367:
	.cfi_endproc
.LFE51:
	.size	lwt_yield, .-lwt_yield
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.text.unlikely
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	lwt_join
	.type	lwt_join, @function
lwt_join:
.LFB52:
	.loc 1 397 0
	.cfi_startproc
.LVL239:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 397 0
	movl	16(%esp), %edx
	.loc 1 399 0
	testl	%edx, %edx
	je	.L529
	.loc 1 406 0
	cmpl	$2, 4(%edx)
	je	.L581
	.loc 1 415 0
	movl	current_thread, %ecx
	.loc 1 404 0
	xorl	%eax, %eax
	.loc 1 415 0
	cmpl	%ecx, %edx
	je	.L561
	.loc 1 422 0
	movl	16(%edx), %ebx
	testl	%ebx, %ebx
	je	.L582
.L561:
	.loc 1 444 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
	.p2align 3
.L582:
	.cfi_restore_state
	.loc 1 436 0
	movl	valid_queue, %ebx
.LVL240:
	.loc 1 430 0
	movl	%edx, 20(%ecx)
	.loc 1 431 0
	movl	%ecx, 16(%edx)
	.loc 1 435 0
	movl	$1, 4(%ecx)
.LBB382:
.LBB383:
	.loc 1 90 0
	movl	8(%ebx), %esi
	.loc 1 89 0
	movl	(%ebx), %eax
.LVL241:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L502
.LVL242:
	.loc 1 91 0
	testl	%eax, %eax
	je	.L579
	.loc 1 93 0
	cmpl	%ecx, %eax
	je	.L505
	movl	%eax, %edx
.LVL243:
	jmp	.L507
.LVL244:
	.p2align 4,,10
	.p2align 3
.L515:
	cmpl	%edx, %ecx
	je	.L583
.L507:
	.loc 1 125 0
	movl	8(%edx), %edx
.LVL245:
	.loc 1 91 0
	testl	%edx, %edx
	jne	.L515
.LVL246:
.L579:
	addl	$1, %esi
.LVL247:
.LBE383:
.LBE382:
.LBB388:
.LBB389:
	.loc 1 41 0
	movl	$0, 8(%ecx)
.L516:
	.loc 1 52 0
	movl	4(%ebx), %edx
.LBE389:
.LBE388:
.LBB395:
.LBB396:
.LBB397:
.LBB398:
	.loc 1 138 0
	testl	%eax, %eax
.LBE398:
.LBE397:
	.loc 1 188 0
	movl	%ecx, old_thread
.LBE396:
.LBE395:
.LBB407:
.LBB390:
	.loc 1 52 0
	movl	%ecx, 8(%edx)
	.loc 1 53 0
	movl	%edx, 12(%ecx)
	.loc 1 54 0
	movl	%ecx, 4(%ebx)
	.loc 1 57 0
	movl	%esi, 8(%ebx)
.LVL248:
.LBE390:
.LBE407:
.LBB408:
.LBB403:
.LBB400:
.LBB399:
	.loc 1 138 0
	jne	.L522
	jmp	.L518
.LVL249:
	.p2align 4,,10
	.p2align 3
.L584:
	.loc 1 144 0
	movl	8(%eax), %eax
.LVL250:
	.loc 1 138 0
	testl	%eax, %eax
	je	.L518
.LVL251:
.L522:
	.loc 1 140 0
	movl	4(%eax), %edx
	testl	%edx, %edx
	jne	.L584
.LVL252:
.LBE399:
.LBE400:
	.loc 1 190 0
	cmpl	%eax, %ecx
	.loc 1 189 0
	movl	%eax, current_thread
	.loc 1 190 0
	je	.L524
.LVL253:
.LBB401:
.LBB402:
	.loc 1 152 0
#APP
# 152 "lwt.c" 1
	mov 0xc(%ebp),%eax
	mov 0x4(%eax),%ecx
	mov (%eax),%edx
	mov 0x8(%ebp),%eax
	add $0x4,%eax
	mov 0x8(%ebp),%ebx
	push %ebp
	push %ebx
	mov %esp,(%eax)
	movl $label_1,(%ebx)
	mov %ecx,%esp
	jmp *%edx
	label_1:pop %ebx
	pop %ebp
	
# 0 "" 2
.LVL254:
#NO_APP
.L524:
.LBE402:
.LBE401:
.LBE403:
.LBE408:
	.loc 1 442 0
	movl	$0, 20(%eax)
	.loc 1 443 0
	movl	28(%eax), %eax
	.loc 1 444 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL255:
	.p2align 4,,10
	.p2align 3
.L518:
	.cfi_restore_state
.LBB409:
.LBB404:
	.loc 1 189 0
	movl	$0, current_thread
.LBE404:
.LBE409:
	.loc 1 442 0
	movl	$0, 20
.LVL256:
	ud2
.LVL257:
	.p2align 4,,10
	.p2align 3
.L583:
.LBB410:
.LBB384:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L502
	.loc 1 102 0
	cmpl	%ecx, %eax
	je	.L527
	.loc 1 110 0
	cmpl	%ecx, 4(%ebx)
	.loc 1 112 0
	movl	12(%ecx), %eax
	.loc 1 110 0
	je	.L585
	.loc 1 118 0
	testl	%eax, %eax
	je	.L513
	.loc 1 119 0
	movl	8(%ecx), %edi
	movl	%edi, 8(%eax)
.L513:
	.loc 1 120 0
	movl	8(%edx), %edx
.LVL258:
	testl	%edx, %edx
	je	.L514
	.loc 1 121 0
	movl	%eax, 12(%edx)
.L514:
	.loc 1 122 0
	leal	-1(%esi), %eax
.LBE384:
.LBE410:
.LBB411:
.LBB391:
	.loc 1 44 0
	testl	%eax, %eax
.LBE391:
.LBE411:
.LBB412:
.LBB385:
	.loc 1 122 0
	movl	%eax, 8(%ebx)
.LVL259:
.LBE385:
.LBE412:
.LBB413:
.LBB392:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	.loc 1 44 0
	jne	.L586
.L528:
	.loc 1 46 0
	movl	%ecx, (%ebx)
	.loc 1 47 0
	movl	%ecx, 4(%ebx)
.LBE392:
.LBE413:
.LBB414:
.LBB405:
	.loc 1 188 0
	movl	%ecx, %eax
.LBE405:
.LBE414:
.LBB415:
.LBB393:
	.loc 1 57 0
	movl	%esi, 8(%ebx)
.LVL260:
.LBE393:
.LBE415:
.LBB416:
.LBB406:
	.loc 1 188 0
	movl	%ecx, old_thread
.LVL261:
	jmp	.L522
.LVL262:
	.p2align 4,,10
	.p2align 3
.L581:
.LBE406:
.LBE416:
	.loc 1 411 0
	movl	zombie_queue, %ebx
.LVL263:
.LBB417:
.LBB418:
	.loc 1 90 0
	movl	8(%ebx), %esi
	.loc 1 89 0
	movl	(%ebx), %ecx
.LVL264:
	.loc 1 90 0
	testl	%esi, %esi
	je	.L488
	.loc 1 91 0
	testl	%ecx, %ecx
	je	.L488
	.loc 1 93 0
	cmpl	%ecx, %edx
	je	.L489
	movl	%ecx, %eax
	jmp	.L491
.LVL265:
	.p2align 4,,10
	.p2align 3
.L499:
	cmpl	%eax, %edx
	je	.L587
.L491:
	.loc 1 125 0
	movl	8(%eax), %eax
.LVL266:
	.loc 1 91 0
	testl	%eax, %eax
	jne	.L499
.LVL267:
.L488:
.LBE418:
.LBE417:
	.loc 1 412 0
	movl	recycle_queue, %eax
.LVL268:
.LBB421:
.LBB422:
	.loc 1 41 0
	movl	$0, 8(%edx)
	.loc 1 42 0
	movl	$0, 12(%edx)
	.loc 1 44 0
	movl	8(%eax), %ecx
	testl	%ecx, %ecx
	jne	.L500
	.loc 1 46 0
	movl	%edx, (%eax)
	.loc 1 47 0
	movl	%edx, 4(%eax)
.L501:
	.loc 1 57 0
	addl	$1, %ecx
	movl	%ecx, 8(%eax)
.LVL269:
.LBE422:
.LBE421:
	.loc 1 413 0
	movl	28(%edx), %eax
	.loc 1 444 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.LVL270:
	.p2align 4,,10
	.p2align 3
.L500:
	.cfi_restore_state
.LBB424:
.LBB423:
	.loc 1 52 0
	movl	4(%eax), %ebx
	movl	%edx, 8(%ebx)
	.loc 1 53 0
	movl	%ebx, 12(%edx)
	.loc 1 54 0
	movl	%edx, 4(%eax)
	jmp	.L501
.LVL271:
	.p2align 4,,10
	.p2align 3
.L587:
.LBE423:
.LBE424:
.LBB425:
.LBB419:
	.loc 1 95 0
	cmpl	$1, %esi
	je	.L525
	.loc 1 102 0
	cmpl	%edx, %ecx
	je	.L526
	.loc 1 110 0
	cmpl	%edx, 4(%ebx)
	je	.L588
	.loc 1 118 0
	movl	12(%edx), %ecx
	testl	%ecx, %ecx
	je	.L497
	.loc 1 119 0
	movl	8(%edx), %edi
	movl	%edi, 8(%ecx)
.L497:
	.loc 1 120 0
	movl	8(%eax), %eax
.LVL272:
	testl	%eax, %eax
	je	.L498
	.loc 1 121 0
	movl	%ecx, 12(%eax)
.L498:
	.loc 1 122 0
	subl	$1, %esi
	movl	%esi, 8(%ebx)
	jmp	.L488
.LVL273:
.L489:
	.loc 1 95 0
	cmpl	$1, %esi
	jne	.L526
.LVL274:
.L525:
	.loc 1 97 0
	movl	$0, (%ebx)
	.loc 1 98 0
	movl	$0, 4(%ebx)
	.loc 1 99 0
	movl	$0, 8(%ebx)
	jmp	.L488
.LVL275:
.L505:
.LBE419:
.LBE425:
.LBB426:
.LBB386:
	.loc 1 95 0
	cmpl	$1, %esi
	jne	.L527
.LVL276:
	.p2align 4,,10
	.p2align 3
.L502:
.LBE386:
.LBE426:
.LBB427:
.LBB394:
	.loc 1 41 0
	movl	$0, 8(%ecx)
	.loc 1 42 0
	movl	$0, 12(%ecx)
	movl	$1, %esi
	jmp	.L528
.LVL277:
.L529:
.LBE394:
.LBE427:
	.loc 1 404 0
	xorl	%eax, %eax
	jmp	.L561
.LVL278:
.L527:
.LBB428:
.LBB387:
	.loc 1 104 0
	movl	8(%eax), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ebx)
	.loc 1 105 0
	je	.L514
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L514
.LVL279:
.L585:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ebx)
	.loc 1 113 0
	je	.L514
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L514
.LVL280:
.L526:
.LBE387:
.LBE428:
.LBB429:
.LBB420:
	.loc 1 104 0
	movl	8(%ecx), %eax
	.loc 1 105 0
	testl	%eax, %eax
	.loc 1 104 0
	movl	%eax, (%ebx)
	.loc 1 105 0
	je	.L498
	.loc 1 106 0
	movl	$0, 12(%eax)
	jmp	.L498
.LVL281:
.L588:
	.loc 1 112 0
	movl	12(%edx), %eax
.LVL282:
	.loc 1 113 0
	testl	%eax, %eax
	.loc 1 112 0
	movl	%eax, 4(%ebx)
	.loc 1 113 0
	je	.L498
	.loc 1 114 0
	movl	$0, 8(%eax)
	jmp	.L498
.LVL283:
.L586:
	movl	(%ebx), %eax
	jmp	.L516
.LBE420:
.LBE429:
	.cfi_endproc
.LFE52:
	.size	lwt_join, .-lwt_join
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.text.unlikely
.LCOLDB14:
	.text
.LHOTB14:
	.p2align 4,,15
	.globl	lwt_current
	.type	lwt_current, @function
lwt_current:
.LFB53:
	.loc 1 449 0
	.cfi_startproc
	.loc 1 450 0
	movl	thread_initiated, %eax
	testl	%eax, %eax
	je	.L590
	movl	current_thread, %eax
	.loc 1 452 0
	ret
	.p2align 4,,10
	.p2align 3
.L590:
	.loc 1 449 0
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$16, %esp
	.cfi_def_cfa_offset 28
.LBB443:
.LBB444:
	.loc 1 268 0
	movl	$1, thread_initiated
.LVL284:
.LBB445:
.LBB446:
	.loc 1 209 0
	pushl	$40
	.cfi_def_cfa_offset 32
	call	malloc
.LVL285:
	movl	%eax, %ebx
.LVL286:
	.loc 1 210 0
	movl	lwt_counter, %eax
.LVL287:
.LBE446:
.LBE445:
.LBB449:
.LBB450:
	.loc 1 284 0
	movl	$12, (%esp)
.LBE450:
.LBE449:
.LBB453:
.LBB447:
	.loc 1 211 0
	movl	$0, 4(%ebx)
	.loc 1 212 0
	movl	$0, 8(%ebx)
	.loc 1 213 0
	movl	$0, 12(%ebx)
	.loc 1 214 0
	movl	$0, 16(%ebx)
	.loc 1 210 0
	leal	1(%eax), %edx
	movl	%eax, (%ebx)
	.loc 1 215 0
	movl	$0, 20(%ebx)
	.loc 1 216 0
	movl	$0, 28(%ebx)
.LVL288:
.LBE447:
.LBE453:
	.loc 1 269 0
	movl	%ebx, current_thread
.LBB454:
.LBB448:
	.loc 1 210 0
	movl	%edx, lwt_counter
.LBE448:
.LBE454:
.LBB455:
.LBB451:
	.loc 1 284 0
	call	malloc
.LVL289:
.LBE451:
.LBE455:
.LBB456:
.LBB457:
	movl	$12, (%esp)
.LBE457:
.LBE456:
.LBB459:
.LBB452:
	movl	%eax, %esi
.LBE452:
.LBE459:
	.loc 1 271 0
	movl	%eax, valid_queue
.LBB460:
.LBB458:
	.loc 1 284 0
	call	malloc
.LVL290:
	.loc 1 285 0
	movl	$0, 8(%eax)
	.loc 1 286 0
	movl	$0, (%eax)
	.loc 1 287 0
	movl	$0, 4(%eax)
.LVL291:
.LBE458:
.LBE460:
	.loc 1 273 0
	movl	%eax, recycle_queue
.LBB461:
.LBB462:
	.loc 1 284 0
	movl	$12, (%esp)
	call	malloc
.LVL292:
.LBE462:
.LBE461:
.LBB464:
.LBB465:
	.loc 1 46 0
	movl	%ebx, (%esi)
.LBE465:
.LBE464:
.LBB468:
.LBB463:
	.loc 1 285 0
	movl	$0, 8(%eax)
	.loc 1 286 0
	movl	$0, (%eax)
	.loc 1 287 0
	movl	$0, 4(%eax)
.LVL293:
.LBE463:
.LBE468:
.LBB469:
.LBB466:
	.loc 1 47 0
	movl	%ebx, 4(%esi)
.LBE466:
.LBE469:
	.loc 1 275 0
	movl	%eax, zombie_queue
.LVL294:
.LBB470:
.LBB467:
	.loc 1 57 0
	movl	%ebx, %eax
	movl	$1, 8(%esi)
.LVL295:
.LBE467:
.LBE470:
.LBE444:
.LBE443:
	.loc 1 452 0
	addl	$20, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE53:
	.size	lwt_current, .-lwt_current
	.section	.text.unlikely
.LCOLDE14:
	.text
.LHOTE14:
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.p2align 4,,15
	.globl	lwt_id
	.type	lwt_id, @function
lwt_id:
.LFB54:
	.loc 1 457 0
	.cfi_startproc
.LVL296:
	.loc 1 458 0
	movl	current_thread, %eax
	movl	(%eax), %eax
	.loc 1 459 0
	ret
	.cfi_endproc
.LFE54:
	.size	lwt_id, .-lwt_id
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC16:
	.string	"there are %d living thread, status shows as below:\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC17:
	.string	"thread: %d with status %d\n"
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.globl	print_living_thread_info
	.type	print_living_thread_info, @function
print_living_thread_info:
.LFB55:
	.loc 1 464 0
	.cfi_startproc
.LVL297:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$12, %esp
	.cfi_def_cfa_offset 20
	.loc 1 465 0
	movl	valid_queue, %eax
.LBB471:
.LBB472:
	.file 2 "/usr/include/i386-linux-gnu/bits/stdio2.h"
	.loc 2 104 0
	pushl	8(%eax)
	.cfi_def_cfa_offset 24
	pushl	$.LC16
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL298:
.LBE472:
.LBE471:
	.loc 1 466 0
	movl	valid_queue, %eax
	.loc 1 467 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 466 0
	movl	(%eax), %ebx
.LVL299:
	.loc 1 467 0
	testl	%ebx, %ebx
	je	.L594
	.p2align 4,,10
	.p2align 3
.L598:
.LVL300:
.LBB473:
.LBB474:
	.loc 2 104 0
	pushl	4(%ebx)
	.cfi_def_cfa_offset 20
	pushl	(%ebx)
	.cfi_def_cfa_offset 24
	pushl	$.LC17
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL301:
.LBE474:
.LBE473:
	.loc 1 470 0
	movl	8(%ebx), %ebx
.LVL302:
	.loc 1 467 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%ebx, %ebx
	jne	.L598
.L594:
	.loc 1 472 0
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL303:
	ret
	.cfi_endproc
.LFE55:
	.size	print_living_thread_info, .-print_living_thread_info
	.section	.text.unlikely
.LCOLDE18:
	.text
.LHOTE18:
	.section	.rodata.str1.4
	.align 4
.LC19:
	.string	"there are %d dead thread in recycle, status shows as below:\n"
	.align 4
.LC20:
	.string	"thread: %d in recycle queue with status %d\n"
	.section	.text.unlikely
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.globl	print_recycle_thread_info
	.type	print_recycle_thread_info, @function
print_recycle_thread_info:
.LFB56:
	.loc 1 477 0
	.cfi_startproc
.LVL304:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$12, %esp
	.cfi_def_cfa_offset 20
	.loc 1 478 0
	movl	recycle_queue, %eax
.LBB475:
.LBB476:
	.loc 2 104 0
	pushl	8(%eax)
	.cfi_def_cfa_offset 24
	pushl	$.LC19
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL305:
.LBE476:
.LBE475:
	.loc 1 479 0
	movl	recycle_queue, %eax
	.loc 1 480 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 479 0
	movl	(%eax), %ebx
.LVL306:
	.loc 1 480 0
	testl	%ebx, %ebx
	je	.L601
	.p2align 4,,10
	.p2align 3
.L605:
.LVL307:
.LBB477:
.LBB478:
	.loc 2 104 0
	pushl	4(%ebx)
	.cfi_def_cfa_offset 20
	pushl	(%ebx)
	.cfi_def_cfa_offset 24
	pushl	$.LC20
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL308:
.LBE478:
.LBE477:
	.loc 1 483 0
	movl	8(%ebx), %ebx
.LVL309:
	.loc 1 480 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%ebx, %ebx
	jne	.L605
.L601:
	.loc 1 485 0
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL310:
	ret
	.cfi_endproc
.LFE56:
	.size	print_recycle_thread_info, .-print_recycle_thread_info
	.section	.text.unlikely
.LCOLDE21:
	.text
.LHOTE21:
	.section	.rodata.str1.4
	.align 4
.LC22:
	.string	"there are %d zombie thread, status shows as below:\n"
	.align 4
.LC23:
	.string	"thread: %d in zombie queue with status %d\n"
	.section	.text.unlikely
.LCOLDB24:
	.text
.LHOTB24:
	.p2align 4,,15
	.globl	print_zombie_thread_info
	.type	print_zombie_thread_info, @function
print_zombie_thread_info:
.LFB57:
	.loc 1 490 0
	.cfi_startproc
.LVL311:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$12, %esp
	.cfi_def_cfa_offset 20
	.loc 1 491 0
	movl	zombie_queue, %eax
.LBB479:
.LBB480:
	.loc 2 104 0
	pushl	8(%eax)
	.cfi_def_cfa_offset 24
	pushl	$.LC22
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL312:
.LBE480:
.LBE479:
	.loc 1 492 0
	movl	zombie_queue, %eax
	.loc 1 493 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.loc 1 492 0
	movl	(%eax), %ebx
.LVL313:
	.loc 1 493 0
	testl	%ebx, %ebx
	je	.L608
	.p2align 4,,10
	.p2align 3
.L612:
.LVL314:
.LBB481:
.LBB482:
	.loc 2 104 0
	pushl	4(%ebx)
	.cfi_def_cfa_offset 20
	pushl	(%ebx)
	.cfi_def_cfa_offset 24
	pushl	$.LC23
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	__printf_chk
.LVL315:
.LBE482:
.LBE481:
	.loc 1 496 0
	movl	8(%ebx), %ebx
.LVL316:
	.loc 1 493 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%ebx, %ebx
	jne	.L612
.L608:
	.loc 1 498 0
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL317:
	ret
	.cfi_endproc
.LFE57:
	.size	print_zombie_thread_info, .-print_zombie_thread_info
	.section	.text.unlikely
.LCOLDE24:
	.text
.LHOTE24:
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.p2align 4,,15
	.globl	lwt_info
	.type	lwt_info, @function
lwt_info:
.LFB58:
	.loc 1 502 0
	.cfi_startproc
.LVL318:
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	.loc 1 502 0
	movl	8(%esp), %ebx
	.loc 1 503 0
	cmpl	$2, %ebx
	je	.L622
.LVL319:
	.loc 1 508 0
	movl	valid_queue, %eax
	movl	(%eax), %edx
.LVL320:
	.loc 1 509 0
	xorl	%eax, %eax
	testl	%edx, %edx
	je	.L617
.LVL321:
	.p2align 4,,10
	.p2align 3
.L618:
	xorl	%ecx, %ecx
	cmpl	4(%edx), %ebx
	.loc 1 512 0
	movl	8(%edx), %edx
	sete	%cl
	addl	%ecx, %eax
.LVL322:
	.loc 1 509 0
	testl	%edx, %edx
	jne	.L618
.LVL323:
.L617:
	.loc 1 515 0
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL324:
	ret
.LVL325:
	.p2align 4,,10
	.p2align 3
.L622:
	.cfi_restore_state
	.loc 1 504 0
	movl	zombie_queue, %eax
	.loc 1 515 0
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
.LVL326:
	.loc 1 504 0
	movl	8(%eax), %eax
	.loc 1 515 0
	ret
	.cfi_endproc
.LFE58:
	.size	lwt_info, .-lwt_info
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.comm	old_thread,4,4
	.comm	current_thread,4,4
	.comm	zombie_queue,4,4
	.comm	recycle_queue,4,4
	.comm	valid_queue,4,4
	.globl	thread_initiated
	.bss
	.align 4
	.type	thread_initiated, @object
	.size	thread_initiated, 4
thread_initiated:
	.zero	4
	.globl	lwt_counter
	.align 4
	.type	lwt_counter, @object
	.size	lwt_counter, 4
lwt_counter:
	.zero	4
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 3 "/usr/lib/gcc/i686-linux-gnu/5/include/stddef.h"
	.file 4 "/usr/include/i386-linux-gnu/bits/types.h"
	.file 5 "/usr/include/libio.h"
	.file 6 "lwt.h"
	.file 7 "/usr/include/stdio.h"
	.file 8 "/usr/include/stdlib.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x13a2
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF119
	.byte	0xc
	.long	.LASF120
	.long	.LASF121
	.long	.Ltext0
	.long	.Letext0-.Ltext0
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
	.long	.LASF122
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
	.uleb128 0x2
	.long	.LASF49
	.byte	0x6
	.byte	0x11
	.long	0x5a
	.uleb128 0x2
	.long	.LASF50
	.byte	0x6
	.byte	0x14
	.long	0x2b5
	.uleb128 0x6
	.byte	0x4
	.long	0x2bb
	.uleb128 0xe
	.long	0x9e
	.long	0x2ca
	.uleb128 0xf
	.long	0x9e
	.byte	0
	.uleb128 0x10
	.long	.LASF123
	.byte	0x4
	.long	0x30
	.byte	0x6
	.byte	0x17
	.long	0x2ed
	.uleb128 0x11
	.long	.LASF51
	.byte	0
	.uleb128 0x11
	.long	.LASF52
	.byte	0x1
	.uleb128 0x11
	.long	.LASF53
	.byte	0x2
	.byte	0
	.uleb128 0x2
	.long	.LASF54
	.byte	0x6
	.byte	0x20
	.long	0x2ca
	.uleb128 0x7
	.long	.LASF55
	.byte	0x8
	.byte	0x6
	.byte	0x23
	.long	0x31b
	.uleb128 0x12
	.string	"ip"
	.byte	0x6
	.byte	0x25
	.long	0x30
	.byte	0
	.uleb128 0x12
	.string	"sp"
	.byte	0x6
	.byte	0x25
	.long	0x30
	.byte	0x4
	.byte	0
	.uleb128 0x2
	.long	.LASF56
	.byte	0x6
	.byte	0x27
	.long	0x2f8
	.uleb128 0x7
	.long	.LASF57
	.byte	0x28
	.byte	0x6
	.byte	0x2a
	.long	0x39f
	.uleb128 0x8
	.long	.LASF58
	.byte	0x6
	.byte	0x2d
	.long	0x29f
	.byte	0
	.uleb128 0x8
	.long	.LASF59
	.byte	0x6
	.byte	0x30
	.long	0x2ed
	.byte	0x4
	.uleb128 0x8
	.long	.LASF60
	.byte	0x6
	.byte	0x33
	.long	0x39f
	.byte	0x8
	.uleb128 0x8
	.long	.LASF61
	.byte	0x6
	.byte	0x34
	.long	0x39f
	.byte	0xc
	.uleb128 0x8
	.long	.LASF62
	.byte	0x6
	.byte	0x37
	.long	0x39f
	.byte	0x10
	.uleb128 0x8
	.long	.LASF63
	.byte	0x6
	.byte	0x38
	.long	0x39f
	.byte	0x14
	.uleb128 0x8
	.long	.LASF64
	.byte	0x6
	.byte	0x3b
	.long	0x30
	.byte	0x18
	.uleb128 0x8
	.long	.LASF65
	.byte	0x6
	.byte	0x3e
	.long	0x9e
	.byte	0x1c
	.uleb128 0x8
	.long	.LASF66
	.byte	0x6
	.byte	0x41
	.long	0x31b
	.byte	0x20
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x326
	.uleb128 0x2
	.long	.LASF67
	.byte	0x6
	.byte	0x43
	.long	0x39f
	.uleb128 0x7
	.long	.LASF68
	.byte	0xc
	.byte	0x6
	.byte	0x46
	.long	0x3e1
	.uleb128 0x8
	.long	.LASF69
	.byte	0x6
	.byte	0x48
	.long	0x3a5
	.byte	0
	.uleb128 0x8
	.long	.LASF70
	.byte	0x6
	.byte	0x48
	.long	0x3a5
	.byte	0x4
	.uleb128 0x8
	.long	.LASF71
	.byte	0x6
	.byte	0x49
	.long	0x5a
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.long	.LASF72
	.byte	0x6
	.byte	0x4b
	.long	0x3b0
	.uleb128 0x13
	.long	.LASF75
	.byte	0x1
	.byte	0x87
	.long	0x3a5
	.byte	0x1
	.long	0x413
	.uleb128 0x14
	.long	.LASF73
	.byte	0x1
	.byte	0x87
	.long	0x413
	.uleb128 0x15
	.long	.LASF74
	.byte	0x1
	.byte	0x89
	.long	0x3a5
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x3e1
	.uleb128 0x16
	.long	.LASF78
	.byte	0x1
	.byte	0x96
	.byte	0x1
	.long	0x43c
	.uleb128 0x14
	.long	.LASF74
	.byte	0x1
	.byte	0x96
	.long	0x43c
	.uleb128 0x14
	.long	.LASF60
	.byte	0x1
	.byte	0x96
	.long	0x43c
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.long	0x31b
	.uleb128 0x13
	.long	.LASF76
	.byte	0x1
	.byte	0x27
	.long	0x5a
	.byte	0x1
	.long	0x469
	.uleb128 0x14
	.long	.LASF77
	.byte	0x1
	.byte	0x27
	.long	0x3a5
	.uleb128 0x14
	.long	.LASF73
	.byte	0x1
	.byte	0x27
	.long	0x413
	.byte	0
	.uleb128 0x17
	.long	.LASF79
	.byte	0x1
	.value	0x11a
	.long	0x413
	.byte	0x1
	.long	0x487
	.uleb128 0x18
	.long	.LASF80
	.byte	0x1
	.value	0x11c
	.long	0x413
	.byte	0
	.uleb128 0x13
	.long	.LASF81
	.byte	0x1
	.byte	0x3f
	.long	0x5a
	.byte	0x1
	.long	0x4ae
	.uleb128 0x14
	.long	.LASF77
	.byte	0x1
	.byte	0x3f
	.long	0x3a5
	.uleb128 0x14
	.long	.LASF73
	.byte	0x1
	.byte	0x3f
	.long	0x413
	.byte	0
	.uleb128 0x19
	.long	.LASF102
	.byte	0x2
	.byte	0x66
	.long	0x5a
	.byte	0x3
	.long	0x4cb
	.uleb128 0x14
	.long	.LASF82
	.byte	0x2
	.byte	0x66
	.long	0x4cb
	.uleb128 0x1a
	.byte	0
	.uleb128 0x1b
	.long	0x294
	.uleb128 0x13
	.long	.LASF83
	.byte	0x1
	.byte	0xcf
	.long	0x3a5
	.byte	0x1
	.long	0x519
	.uleb128 0x14
	.long	.LASF84
	.byte	0x1
	.byte	0xcf
	.long	0x5a
	.uleb128 0x1c
	.string	"fn"
	.byte	0x1
	.byte	0xcf
	.long	0x2aa
	.uleb128 0x14
	.long	.LASF85
	.byte	0x1
	.byte	0xcf
	.long	0x9e
	.uleb128 0x15
	.long	.LASF86
	.byte	0x1
	.byte	0xd1
	.long	0x3a5
	.uleb128 0x1d
	.uleb128 0x1e
	.string	"_sp"
	.byte	0x1
	.byte	0xdd
	.long	0x30
	.byte	0
	.byte	0
	.uleb128 0x1f
	.long	.LASF87
	.byte	0x1
	.value	0x135
	.byte	0x1
	.long	0x533
	.uleb128 0x20
	.long	.LASF88
	.byte	0x1
	.value	0x135
	.long	0x9e
	.byte	0
	.uleb128 0x13
	.long	.LASF89
	.byte	0x1
	.byte	0x57
	.long	0x5a
	.byte	0x1
	.long	0x565
	.uleb128 0x14
	.long	.LASF77
	.byte	0x1
	.byte	0x57
	.long	0x3a5
	.uleb128 0x14
	.long	.LASF73
	.byte	0x1
	.byte	0x57
	.long	0x413
	.uleb128 0x15
	.long	.LASF90
	.byte	0x1
	.byte	0x59
	.long	0x3a5
	.byte	0
	.uleb128 0x21
	.long	.LASF124
	.byte	0x1
	.byte	0xba
	.byte	0x1
	.uleb128 0x22
	.long	.LASF93
	.byte	0x1
	.value	0x159
	.long	0x9e
	.long	.LFB50
	.long	.LFE50-.LFB50
	.uleb128 0x1
	.byte	0x9c
	.long	0x6ed
	.uleb128 0x23
	.string	"fn"
	.byte	0x1
	.value	0x159
	.long	0x2aa
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x24
	.long	.LASF85
	.byte	0x1
	.value	0x159
	.long	0x9e
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x25
	.long	.LASF95
	.byte	0x1
	.value	0x15b
	.long	0x9e
	.long	.LLST0
	.uleb128 0x26
	.long	0x519
	.long	.LBB59
	.long	.Ldebug_ranges0+0
	.byte	0x1
	.value	0x15f
	.long	0x6e3
	.uleb128 0x27
	.long	0x526
	.long	.LLST0
	.uleb128 0x26
	.long	0x533
	.long	.LBB61
	.long	.Ldebug_ranges0+0x28
	.byte	0x1
	.value	0x142
	.long	0x607
	.uleb128 0x27
	.long	0x54e
	.long	.LLST2
	.uleb128 0x27
	.long	0x543
	.long	.LLST3
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x28
	.uleb128 0x29
	.long	0x559
	.long	.LLST4
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x442
	.long	.LBB66
	.long	.Ldebug_ranges0+0x50
	.byte	0x1
	.value	0x143
	.long	0x62e
	.uleb128 0x27
	.long	0x45d
	.long	.LLST5
	.uleb128 0x27
	.long	0x452
	.long	.LLST6
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB69
	.long	.Ldebug_ranges0+0x68
	.byte	0x1
	.value	0x154
	.long	0x689
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB71
	.long	.Ldebug_ranges0+0x80
	.byte	0x1
	.byte	0xbd
	.long	0x66e
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST7
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x80
	.uleb128 0x29
	.long	0x407
	.long	.LLST8
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB75
	.long	.LBE75-.LBB75
	.byte	0x1
	.byte	0xc3
	.uleb128 0x2c
	.long	0x430
	.uleb128 0x2c
	.long	0x425
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x533
	.long	.LBB81
	.long	.Ldebug_ranges0+0x98
	.byte	0x1
	.value	0x14c
	.long	0x6bf
	.uleb128 0x27
	.long	0x54e
	.long	.LLST9
	.uleb128 0x27
	.long	0x543
	.long	.LLST10
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x98
	.uleb128 0x29
	.long	0x559
	.long	.LLST11
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB85
	.long	.Ldebug_ranges0+0xb8
	.byte	0x1
	.value	0x14d
	.uleb128 0x27
	.long	0x45d
	.long	.LLST12
	.uleb128 0x27
	.long	0x452
	.long	.LLST13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.long	.LVL1
	.uleb128 0x3
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0
	.uleb128 0x2f
	.long	0x442
	.long	.LFB38
	.long	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0x712
	.uleb128 0x27
	.long	0x452
	.long	.LLST14
	.uleb128 0x30
	.long	0x45d
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x2f
	.long	0x487
	.long	.LFB39
	.long	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.long	0x737
	.uleb128 0x27
	.long	0x497
	.long	.LLST15
	.uleb128 0x30
	.long	0x4a2
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x2f
	.long	0x533
	.long	.LFB40
	.long	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.long	0x766
	.uleb128 0x27
	.long	0x543
	.long	.LLST16
	.uleb128 0x27
	.long	0x54e
	.long	.LLST17
	.uleb128 0x29
	.long	0x559
	.long	.LLST18
	.byte	0
	.uleb128 0x2f
	.long	0x3ec
	.long	.LFB41
	.long	.LFE41-.LFB41
	.uleb128 0x1
	.byte	0x9c
	.long	0x78b
	.uleb128 0x30
	.long	0x3fc
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x29
	.long	0x407
	.long	.LLST19
	.byte	0
	.uleb128 0x2f
	.long	0x419
	.long	.LFB42
	.long	.LFE42-.LFB42
	.uleb128 0x1
	.byte	0x9c
	.long	0x7af
	.uleb128 0x30
	.long	0x425
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x30
	.long	0x430
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x2f
	.long	0x565
	.long	.LFB43
	.long	.LFE43-.LFB43
	.uleb128 0x1
	.byte	0x9c
	.long	0x80d
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB103
	.long	.Ldebug_ranges0+0xd0
	.byte	0x1
	.byte	0xbd
	.long	0x7ee
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST20
	.uleb128 0x28
	.long	.Ldebug_ranges0+0xd0
	.uleb128 0x29
	.long	0x407
	.long	.LLST21
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB109
	.long	.LBE109-.LBB109
	.byte	0x1
	.byte	0xc3
	.uleb128 0x2c
	.long	0x430
	.uleb128 0x27
	.long	0x425
	.long	.LLST22
	.byte	0
	.byte	0
	.uleb128 0x2f
	.long	0x4d0
	.long	.LFB44
	.long	.LFE44-.LFB44
	.uleb128 0x1
	.byte	0x9c
	.long	0x86b
	.uleb128 0x30
	.long	0x4e0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x30
	.long	0x4eb
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x30
	.long	0x4f5
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x29
	.long	0x500
	.long	.LLST23
	.uleb128 0x31
	.long	.LBB112
	.long	.LBE112-.LBB112
	.long	0x861
	.uleb128 0x29
	.long	0x50c
	.long	.LLST24
	.uleb128 0x32
	.long	.LVL80
	.long	0x138e
	.byte	0
	.uleb128 0x32
	.long	.LVL77
	.long	0x138e
	.byte	0
	.uleb128 0x13
	.long	.LASF91
	.byte	0x1
	.byte	0xef
	.long	0x3a5
	.byte	0x1
	.long	0x8a7
	.uleb128 0x1c
	.string	"fn"
	.byte	0x1
	.byte	0xef
	.long	0x2aa
	.uleb128 0x14
	.long	.LASF85
	.byte	0x1
	.byte	0xef
	.long	0x9e
	.uleb128 0x15
	.long	.LASF92
	.byte	0x1
	.byte	0xf1
	.long	0x3a5
	.uleb128 0x1e
	.string	"_sp"
	.byte	0x1
	.byte	0xfd
	.long	0x30
	.byte	0
	.uleb128 0x2f
	.long	0x86b
	.long	.LFB45
	.long	.LFE45-.LFB45
	.uleb128 0x1
	.byte	0x9c
	.long	0x90c
	.uleb128 0x30
	.long	0x87b
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x30
	.long	0x885
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x33
	.long	0x890
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x29
	.long	0x89b
	.long	.LLST25
	.uleb128 0x34
	.long	0x533
	.long	.LBB115
	.long	.Ldebug_ranges0+0xf0
	.byte	0x1
	.byte	0xf2
	.uleb128 0x27
	.long	0x54e
	.long	.LLST26
	.uleb128 0x27
	.long	0x543
	.long	.LLST27
	.uleb128 0x28
	.long	.Ldebug_ranges0+0xf0
	.uleb128 0x29
	.long	0x559
	.long	.LLST27
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2f
	.long	0x469
	.long	.LFB47
	.long	.LFE47-.LFB47
	.uleb128 0x1
	.byte	0x9c
	.long	0x930
	.uleb128 0x33
	.long	0x47a
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x32
	.long	.LVL93
	.long	0x138e
	.byte	0
	.uleb128 0x35
	.long	.LASF125
	.byte	0x1
	.value	0x10a
	.byte	0x1
	.uleb128 0x22
	.long	.LASF94
	.byte	0x1
	.value	0x125
	.long	0x3a5
	.long	.LFB48
	.long	.LFE48-.LFB48
	.uleb128 0x1
	.byte	0x9c
	.long	0xbde
	.uleb128 0x23
	.string	"fn"
	.byte	0x1
	.value	0x125
	.long	0x2aa
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x24
	.long	.LASF85
	.byte	0x1
	.value	0x125
	.long	0x9e
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x25
	.long	.LASF96
	.byte	0x1
	.value	0x128
	.long	0x3a5
	.long	.LLST29
	.uleb128 0x26
	.long	0x86b
	.long	.LBB149
	.long	.Ldebug_ranges0+0x110
	.byte	0x1
	.value	0x12a
	.long	0x9f0
	.uleb128 0x27
	.long	0x885
	.long	.LLST30
	.uleb128 0x27
	.long	0x87b
	.long	.LLST31
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x110
	.uleb128 0x29
	.long	0x890
	.long	.LLST32
	.uleb128 0x29
	.long	0x89b
	.long	.LLST33
	.uleb128 0x34
	.long	0x533
	.long	.LBB151
	.long	.Ldebug_ranges0+0x128
	.byte	0x1
	.byte	0xf2
	.uleb128 0x27
	.long	0x54e
	.long	.LLST34
	.uleb128 0x27
	.long	0x543
	.long	.LLST35
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x128
	.uleb128 0x29
	.long	0x559
	.long	.LLST35
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x36
	.long	0x4d0
	.long	.LBB156
	.long	.LBE156-.LBB156
	.byte	0x1
	.value	0x12a
	.long	0xa5c
	.uleb128 0x27
	.long	0x4f5
	.long	.LLST37
	.uleb128 0x27
	.long	0x4eb
	.long	.LLST38
	.uleb128 0x27
	.long	0x4e0
	.long	.LLST39
	.uleb128 0x37
	.long	.LBB157
	.long	.LBE157-.LBB157
	.uleb128 0x29
	.long	0x500
	.long	.LLST40
	.uleb128 0x31
	.long	.LBB158
	.long	.LBE158-.LBB158
	.long	0xa51
	.uleb128 0x29
	.long	0x50c
	.long	.LLST41
	.uleb128 0x32
	.long	.LVL107
	.long	0x138e
	.byte	0
	.uleb128 0x32
	.long	.LVL104
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x442
	.long	.LBB159
	.long	.Ldebug_ranges0+0x140
	.byte	0x1
	.value	0x12e
	.long	0xa83
	.uleb128 0x27
	.long	0x45d
	.long	.LLST42
	.uleb128 0x27
	.long	0x452
	.long	.LLST43
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB164
	.long	.Ldebug_ranges0+0x168
	.byte	0x1
	.value	0x12f
	.long	0xae2
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB166
	.long	.Ldebug_ranges0+0x1a0
	.byte	0x1
	.byte	0xbd
	.long	0xac3
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST44
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x1a0
	.uleb128 0x29
	.long	0x407
	.long	.LLST45
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB170
	.long	.LBE170-.LBB170
	.byte	0x1
	.byte	0xc3
	.uleb128 0x2c
	.long	0x430
	.uleb128 0x27
	.long	0x425
	.long	.LLST46
	.byte	0
	.byte	0
	.uleb128 0x38
	.long	0x930
	.long	.LBB185
	.long	.LBE185-.LBB185
	.byte	0x1
	.value	0x127
	.uleb128 0x26
	.long	0x4d0
	.long	.LBB187
	.long	.Ldebug_ranges0+0x1b8
	.byte	0x1
	.value	0x10d
	.long	0xb3a
	.uleb128 0x27
	.long	0x4e0
	.long	.LLST47
	.uleb128 0x27
	.long	0x4eb
	.long	.LLST47
	.uleb128 0x27
	.long	0x4f5
	.long	.LLST47
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x1b8
	.uleb128 0x29
	.long	0x500
	.long	.LLST50
	.uleb128 0x32
	.long	.LVL129
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB191
	.long	.Ldebug_ranges0+0x1d0
	.byte	0x1
	.value	0x10f
	.long	0xb63
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x1d0
	.uleb128 0x39
	.long	0x47a
	.uleb128 0x32
	.long	.LVL133
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB194
	.long	.Ldebug_ranges0+0x1e8
	.byte	0x1
	.value	0x111
	.long	0xb90
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x1e8
	.uleb128 0x29
	.long	0x47a
	.long	.LLST51
	.uleb128 0x32
	.long	.LVL134
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB199
	.long	.Ldebug_ranges0+0x200
	.byte	0x1
	.value	0x113
	.long	0xbbd
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x200
	.uleb128 0x29
	.long	0x47a
	.long	.LLST52
	.uleb128 0x32
	.long	.LVL136
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB203
	.long	.Ldebug_ranges0+0x220
	.byte	0x1
	.value	0x114
	.uleb128 0x27
	.long	0x45d
	.long	.LLST53
	.uleb128 0x2c
	.long	0x452
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2f
	.long	0x519
	.long	.LFB49
	.long	.LFE49-.LFB49
	.uleb128 0x1
	.byte	0x9c
	.long	0xd0c
	.uleb128 0x27
	.long	0x526
	.long	.LLST54
	.uleb128 0x26
	.long	0x533
	.long	.LBB226
	.long	.Ldebug_ranges0+0x240
	.byte	0x1
	.value	0x142
	.long	0xc30
	.uleb128 0x27
	.long	0x54e
	.long	.LLST55
	.uleb128 0x27
	.long	0x543
	.long	.LLST56
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x240
	.uleb128 0x29
	.long	0x559
	.long	.LLST57
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x442
	.long	.LBB231
	.long	.Ldebug_ranges0+0x268
	.byte	0x1
	.value	0x143
	.long	0xc57
	.uleb128 0x27
	.long	0x45d
	.long	.LLST58
	.uleb128 0x27
	.long	0x452
	.long	.LLST59
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB234
	.long	.Ldebug_ranges0+0x280
	.byte	0x1
	.value	0x154
	.long	0xcb2
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB236
	.long	.Ldebug_ranges0+0x298
	.byte	0x1
	.byte	0xbd
	.long	0xc97
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST60
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x298
	.uleb128 0x29
	.long	0x407
	.long	.LLST61
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB240
	.long	.LBE240-.LBB240
	.byte	0x1
	.byte	0xc3
	.uleb128 0x2c
	.long	0x430
	.uleb128 0x2c
	.long	0x425
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x533
	.long	.LBB246
	.long	.Ldebug_ranges0+0x2b0
	.byte	0x1
	.value	0x14c
	.long	0xce8
	.uleb128 0x27
	.long	0x54e
	.long	.LLST62
	.uleb128 0x27
	.long	0x543
	.long	.LLST63
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x2b0
	.uleb128 0x29
	.long	0x559
	.long	.LLST64
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB250
	.long	.Ldebug_ranges0+0x2d0
	.byte	0x1
	.value	0x14d
	.uleb128 0x27
	.long	0x45d
	.long	.LLST65
	.uleb128 0x27
	.long	0x452
	.long	.LLST66
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LASF97
	.byte	0x1
	.value	0x164
	.long	0x5a
	.long	.LFB51
	.long	.LFE51-.LFB51
	.uleb128 0x1
	.byte	0x9c
	.long	0xee1
	.uleb128 0x24
	.long	.LASF98
	.byte	0x1
	.value	0x164
	.long	0x3a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x26
	.long	0x533
	.long	.LBB282
	.long	.Ldebug_ranges0+0x2e8
	.byte	0x1
	.value	0x182
	.long	0xd6b
	.uleb128 0x27
	.long	0x54e
	.long	.LLST67
	.uleb128 0x27
	.long	0x543
	.long	.LLST68
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x2e8
	.uleb128 0x29
	.long	0x559
	.long	.LLST69
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x442
	.long	.LBB288
	.long	.Ldebug_ranges0+0x318
	.byte	0x1
	.value	0x183
	.long	0xd92
	.uleb128 0x27
	.long	0x45d
	.long	.LLST70
	.uleb128 0x27
	.long	0x452
	.long	.LLST71
	.byte	0
	.uleb128 0x26
	.long	0x533
	.long	.LBB294
	.long	.Ldebug_ranges0+0x348
	.byte	0x1
	.value	0x184
	.long	0xdc8
	.uleb128 0x27
	.long	0x54e
	.long	.LLST72
	.uleb128 0x27
	.long	0x543
	.long	.LLST73
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x348
	.uleb128 0x29
	.long	0x559
	.long	.LLST74
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x487
	.long	.LBB304
	.long	.Ldebug_ranges0+0x388
	.byte	0x1
	.value	0x185
	.long	0xdef
	.uleb128 0x27
	.long	0x4a2
	.long	.LLST75
	.uleb128 0x27
	.long	0x497
	.long	.LLST76
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB310
	.long	.Ldebug_ranges0+0x3b8
	.byte	0x1
	.value	0x186
	.long	0xe4a
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB312
	.long	.Ldebug_ranges0+0x3d8
	.byte	0x1
	.byte	0xbd
	.long	0xe2f
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST77
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x3d8
	.uleb128 0x29
	.long	0x407
	.long	.LLST78
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB316
	.long	.LBE316-.LBB316
	.byte	0x1
	.byte	0xc3
	.uleb128 0x2c
	.long	0x430
	.uleb128 0x2c
	.long	0x425
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB322
	.long	.Ldebug_ranges0+0x3f0
	.byte	0x1
	.value	0x16f
	.long	0xe87
	.uleb128 0x34
	.long	0x3ec
	.long	.LBB324
	.long	.Ldebug_ranges0+0x410
	.byte	0x1
	.byte	0xbd
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST79
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x410
	.uleb128 0x29
	.long	0x407
	.long	.LLST80
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x533
	.long	.LBB339
	.long	.Ldebug_ranges0+0x428
	.byte	0x1
	.value	0x16c
	.long	0xebd
	.uleb128 0x27
	.long	0x54e
	.long	.LLST81
	.uleb128 0x27
	.long	0x543
	.long	.LLST82
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x428
	.uleb128 0x29
	.long	0x559
	.long	.LLST83
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB345
	.long	.Ldebug_ranges0+0x458
	.byte	0x1
	.value	0x16d
	.uleb128 0x27
	.long	0x45d
	.long	.LLST84
	.uleb128 0x27
	.long	0x452
	.long	.LLST85
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LASF99
	.byte	0x1
	.value	0x18c
	.long	0x9e
	.long	.LFB52
	.long	.LFE52-.LFB52
	.uleb128 0x1
	.byte	0x9c
	.long	0x1025
	.uleb128 0x3a
	.long	.LASF100
	.byte	0x1
	.value	0x18c
	.long	0x3a5
	.long	.LLST86
	.uleb128 0x26
	.long	0x533
	.long	.LBB382
	.long	.Ldebug_ranges0+0x488
	.byte	0x1
	.value	0x1b4
	.long	0xf41
	.uleb128 0x27
	.long	0x54e
	.long	.LLST87
	.uleb128 0x27
	.long	0x543
	.long	.LLST88
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x488
	.uleb128 0x29
	.long	0x559
	.long	.LLST89
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x442
	.long	.LBB388
	.long	.Ldebug_ranges0+0x4b8
	.byte	0x1
	.value	0x1b5
	.long	0xf68
	.uleb128 0x27
	.long	0x45d
	.long	.LLST90
	.uleb128 0x27
	.long	0x452
	.long	.LLST91
	.byte	0
	.uleb128 0x26
	.long	0x565
	.long	.LBB395
	.long	.Ldebug_ranges0+0x4f0
	.byte	0x1
	.value	0x1b6
	.long	0xfcb
	.uleb128 0x2a
	.long	0x3ec
	.long	.LBB397
	.long	.Ldebug_ranges0+0x520
	.byte	0x1
	.byte	0xbd
	.long	0xfa8
	.uleb128 0x27
	.long	0x3fc
	.long	.LLST92
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x520
	.uleb128 0x29
	.long	0x407
	.long	.LLST93
	.byte	0
	.byte	0
	.uleb128 0x2b
	.long	0x419
	.long	.LBB401
	.long	.LBE401-.LBB401
	.byte	0x1
	.byte	0xc3
	.uleb128 0x27
	.long	0x430
	.long	.LLST94
	.uleb128 0x27
	.long	0x425
	.long	.LLST95
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x533
	.long	.LBB417
	.long	.Ldebug_ranges0+0x538
	.byte	0x1
	.value	0x19b
	.long	0x1001
	.uleb128 0x27
	.long	0x54e
	.long	.LLST96
	.uleb128 0x27
	.long	0x543
	.long	.LLST97
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x538
	.uleb128 0x29
	.long	0x559
	.long	.LLST98
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB421
	.long	.Ldebug_ranges0+0x558
	.byte	0x1
	.value	0x19c
	.uleb128 0x27
	.long	0x45d
	.long	.LLST99
	.uleb128 0x27
	.long	0x452
	.long	.LLST100
	.byte	0
	.byte	0
	.uleb128 0x3b
	.long	.LASF126
	.byte	0x1
	.value	0x1c0
	.long	0x3a5
	.long	.LFB53
	.long	.LFE53-.LFB53
	.uleb128 0x1
	.byte	0x9c
	.long	0x113b
	.uleb128 0x38
	.long	0x930
	.long	.LBB443
	.long	.LBE443-.LBB443
	.byte	0x1
	.value	0x1c2
	.uleb128 0x26
	.long	0x4d0
	.long	.LBB445
	.long	.Ldebug_ranges0+0x570
	.byte	0x1
	.value	0x10d
	.long	0x1097
	.uleb128 0x27
	.long	0x4e0
	.long	.LLST101
	.uleb128 0x27
	.long	0x4eb
	.long	.LLST101
	.uleb128 0x27
	.long	0x4f5
	.long	.LLST101
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x570
	.uleb128 0x29
	.long	0x500
	.long	.LLST104
	.uleb128 0x32
	.long	.LVL285
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB449
	.long	.Ldebug_ranges0+0x590
	.byte	0x1
	.value	0x10f
	.long	0x10c0
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x590
	.uleb128 0x39
	.long	0x47a
	.uleb128 0x32
	.long	.LVL289
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB456
	.long	.Ldebug_ranges0+0x5b0
	.byte	0x1
	.value	0x111
	.long	0x10ed
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x5b0
	.uleb128 0x29
	.long	0x47a
	.long	.LLST105
	.uleb128 0x32
	.long	.LVL290
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	0x469
	.long	.LBB461
	.long	.Ldebug_ranges0+0x5c8
	.byte	0x1
	.value	0x113
	.long	0x111a
	.uleb128 0x28
	.long	.Ldebug_ranges0+0x5c8
	.uleb128 0x29
	.long	0x47a
	.long	.LLST106
	.uleb128 0x32
	.long	.LVL292
	.long	0x138e
	.byte	0
	.byte	0
	.uleb128 0x2d
	.long	0x442
	.long	.LBB464
	.long	.Ldebug_ranges0+0x5e0
	.byte	0x1
	.value	0x114
	.uleb128 0x27
	.long	0x45d
	.long	.LLST107
	.uleb128 0x2c
	.long	0x452
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LASF58
	.byte	0x1
	.value	0x1c8
	.long	0x5a
	.long	.LFB54
	.long	.LFE54-.LFB54
	.uleb128 0x1
	.byte	0x9c
	.long	0x1165
	.uleb128 0x24
	.long	.LASF101
	.byte	0x1
	.value	0x1c8
	.long	0x3a5
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.byte	0
	.uleb128 0x3c
	.long	.LASF103
	.byte	0x1
	.value	0x1cf
	.long	.LFB55
	.long	.LFE55-.LFB55
	.uleb128 0x1
	.byte	0x9c
	.long	0x11d6
	.uleb128 0x25
	.long	.LASF104
	.byte	0x1
	.value	0x1d2
	.long	0x3a5
	.long	.LLST108
	.uleb128 0x36
	.long	0x4ae
	.long	.LBB471
	.long	.LBE471-.LBB471
	.byte	0x1
	.value	0x1d1
	.long	0x11b2
	.uleb128 0x27
	.long	0x4be
	.long	.LLST109
	.uleb128 0x32
	.long	.LVL298
	.long	0x139a
	.byte	0
	.uleb128 0x38
	.long	0x4ae
	.long	.LBB473
	.long	.LBE473-.LBB473
	.byte	0x1
	.value	0x1d5
	.uleb128 0x27
	.long	0x4be
	.long	.LLST110
	.uleb128 0x32
	.long	.LVL301
	.long	0x139a
	.byte	0
	.byte	0
	.uleb128 0x3c
	.long	.LASF105
	.byte	0x1
	.value	0x1dc
	.long	.LFB56
	.long	.LFE56-.LFB56
	.uleb128 0x1
	.byte	0x9c
	.long	0x1247
	.uleb128 0x25
	.long	.LASF104
	.byte	0x1
	.value	0x1df
	.long	0x3a5
	.long	.LLST111
	.uleb128 0x36
	.long	0x4ae
	.long	.LBB475
	.long	.LBE475-.LBB475
	.byte	0x1
	.value	0x1de
	.long	0x1223
	.uleb128 0x27
	.long	0x4be
	.long	.LLST112
	.uleb128 0x32
	.long	.LVL305
	.long	0x139a
	.byte	0
	.uleb128 0x38
	.long	0x4ae
	.long	.LBB477
	.long	.LBE477-.LBB477
	.byte	0x1
	.value	0x1e2
	.uleb128 0x27
	.long	0x4be
	.long	.LLST113
	.uleb128 0x32
	.long	.LVL308
	.long	0x139a
	.byte	0
	.byte	0
	.uleb128 0x3c
	.long	.LASF106
	.byte	0x1
	.value	0x1e9
	.long	.LFB57
	.long	.LFE57-.LFB57
	.uleb128 0x1
	.byte	0x9c
	.long	0x12b8
	.uleb128 0x25
	.long	.LASF104
	.byte	0x1
	.value	0x1ec
	.long	0x3a5
	.long	.LLST114
	.uleb128 0x36
	.long	0x4ae
	.long	.LBB479
	.long	.LBE479-.LBB479
	.byte	0x1
	.value	0x1eb
	.long	0x1294
	.uleb128 0x27
	.long	0x4be
	.long	.LLST115
	.uleb128 0x32
	.long	.LVL312
	.long	0x139a
	.byte	0
	.uleb128 0x38
	.long	0x4ae
	.long	.LBB481
	.long	.LBE481-.LBB481
	.byte	0x1
	.value	0x1ef
	.uleb128 0x27
	.long	0x4be
	.long	.LLST116
	.uleb128 0x32
	.long	.LVL315
	.long	0x139a
	.byte	0
	.byte	0
	.uleb128 0x22
	.long	.LASF107
	.byte	0x1
	.value	0x1f5
	.long	0x5a
	.long	.LFB58
	.long	.LFE58-.LFB58
	.uleb128 0x1
	.byte	0x9c
	.long	0x1301
	.uleb128 0x3d
	.string	"t"
	.byte	0x1
	.value	0x1f5
	.long	0x2ed
	.long	.LLST117
	.uleb128 0x3e
	.string	"cnt"
	.byte	0x1
	.value	0x1fa
	.long	0x5a
	.long	.LLST118
	.uleb128 0x25
	.long	.LASF104
	.byte	0x1
	.value	0x1fc
	.long	0x3a5
	.long	.LLST119
	.byte	0
	.uleb128 0x3f
	.long	.LASF108
	.byte	0x7
	.byte	0xa8
	.long	0x268
	.uleb128 0x3f
	.long	.LASF109
	.byte	0x7
	.byte	0xa9
	.long	0x268
	.uleb128 0x40
	.long	.LASF110
	.byte	0x1
	.byte	0x8
	.long	0x5a
	.uleb128 0x5
	.byte	0x3
	.long	lwt_counter
	.uleb128 0x40
	.long	.LASF111
	.byte	0x1
	.byte	0x9
	.long	0x5a
	.uleb128 0x5
	.byte	0x3
	.long	thread_initiated
	.uleb128 0x40
	.long	.LASF112
	.byte	0x1
	.byte	0xc
	.long	0x413
	.uleb128 0x5
	.byte	0x3
	.long	valid_queue
	.uleb128 0x40
	.long	.LASF113
	.byte	0x1
	.byte	0xd
	.long	0x413
	.uleb128 0x5
	.byte	0x3
	.long	recycle_queue
	.uleb128 0x40
	.long	.LASF114
	.byte	0x1
	.byte	0xe
	.long	0x413
	.uleb128 0x5
	.byte	0x3
	.long	zombie_queue
	.uleb128 0x40
	.long	.LASF115
	.byte	0x1
	.byte	0x11
	.long	0x3a5
	.uleb128 0x5
	.byte	0x3
	.long	current_thread
	.uleb128 0x40
	.long	.LASF116
	.byte	0x1
	.byte	0x12
	.long	0x3a5
	.uleb128 0x5
	.byte	0x3
	.long	old_thread
	.uleb128 0x41
	.long	.LASF117
	.long	.LASF117
	.byte	0x8
	.value	0x1d2
	.uleb128 0x42
	.long	.LASF118
	.long	.LASF118
	.byte	0x2
	.byte	0x57
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
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
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x11
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
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
	.uleb128 0x1a
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
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
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xb
	.byte	0x1
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
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0
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
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x23
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
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
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2113
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2f
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
	.uleb128 0x30
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x31
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
	.uleb128 0x32
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x36
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
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x38
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
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x3b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x3c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
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
	.uleb128 0x3d
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x3e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x3f
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
	.uleb128 0x40
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
	.uleb128 0x41
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
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x42
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
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LVL1-.Ltext0
	.long	.LVL4-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL20-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL23-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x2
	.byte	0x72
	.sleb128 28
	.long	.LVL28-.Ltext0
	.long	.LVL29-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL30-.Ltext0
	.long	.LVL33-.Ltext0
	.value	0x2
	.byte	0x72
	.sleb128 28
	.long	.LVL33-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL34-.Ltext0
	.long	.LVL35-.Ltext0
	.value	0x2
	.byte	0x72
	.sleb128 28
	.long	.LVL38-.Ltext0
	.long	.LFE50-.Ltext0
	.value	0x2
	.byte	0x72
	.sleb128 28
	.long	0
	.long	0
.LLST2:
	.long	.LVL2-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL18-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL28-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL35-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST3:
	.long	.LVL2-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL18-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL28-.Ltext0
	.long	.LVL30-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL35-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST4:
	.long	.LVL3-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL5-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL18-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL28-.Ltext0
	.long	.LVL29-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL36-.Ltext0
	.long	.LVL37-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST5:
	.long	.LVL8-.Ltext0
	.long	.LVL9-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL16-.Ltext0
	.long	.LVL17-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST6:
	.long	.LVL8-.Ltext0
	.long	.LVL9-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL16-.Ltext0
	.long	.LVL17-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST7:
	.long	.LVL10-.Ltext0
	.long	.LVL14-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST8:
	.long	.LVL10-.Ltext0
	.long	.LVL11-.Ltext0
	.value	0x2
	.byte	0x71
	.sleb128 0
	.long	.LVL11-.Ltext0
	.long	.LVL12-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 8
	.long	.LVL12-.Ltext0
	.long	.LVL13-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST9:
	.long	.LVL21-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL31-.Ltext0
	.long	.LVL35-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL38-.Ltext0
	.long	.LFE50-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST10:
	.long	.LVL21-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL31-.Ltext0
	.long	.LVL35-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL38-.Ltext0
	.long	.LFE50-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST11:
	.long	.LVL22-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL24-.Ltext0
	.long	.LVL26-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL31-.Ltext0
	.long	.LVL32-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL33-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL39-.Ltext0
	.long	.LVL40-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST12:
	.long	.LVL27-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL30-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST13:
	.long	.LVL27-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL30-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST14:
	.long	.LVL41-.Ltext0
	.long	.LVL42-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL42-.Ltext0
	.long	.LVL43-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL43-.Ltext0
	.long	.LFE38-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST15:
	.long	.LVL44-.Ltext0
	.long	.LVL45-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL45-.Ltext0
	.long	.LVL46-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL46-.Ltext0
	.long	.LFE39-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST16:
	.long	.LVL47-.Ltext0
	.long	.LVL49-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL49-.Ltext0
	.long	.LVL53-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL53-.Ltext0
	.long	.LVL56-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL56-.Ltext0
	.long	.LFE40-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST17:
	.long	.LVL47-.Ltext0
	.long	.LVL55-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL55-.Ltext0
	.long	.LFE40-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST18:
	.long	.LVL48-.Ltext0
	.long	.LVL51-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL52-.Ltext0
	.long	.LVL54-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL56-.Ltext0
	.long	.LVL57-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL58-.Ltext0
	.long	.LVL59-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL60-.Ltext0
	.long	.LVL61-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL61-.Ltext0
	.long	.LVL62-.Ltext0
	.value	0x2
	.byte	0x71
	.sleb128 0
	.long	0
	.long	0
.LLST19:
	.long	.LVL64-.Ltext0
	.long	.LVL66-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL67-.Ltext0
	.long	.LFE41-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST20:
	.long	.LVL69-.Ltext0
	.long	.LVL73-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST21:
	.long	.LVL70-.Ltext0
	.long	.LVL71-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 8
	.long	.LVL71-.Ltext0
	.long	.LVL72-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST22:
	.long	.LVL74-.Ltext0
	.long	.LVL75-.Ltext0
	.value	0x3
	.byte	0x72
	.sleb128 32
	.byte	0x9f
	.long	0
	.long	0
.LLST23:
	.long	.LVL78-.Ltext0
	.long	.LVL79-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL79-.Ltext0
	.long	.LVL84-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL84-.Ltext0
	.long	.LFE44-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST24:
	.long	.LVL80-.Ltext0
	.long	.LVL81-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL81-.Ltext0
	.long	.LVL82-.Ltext0
	.value	0x6
	.byte	0x70
	.sleb128 2097148
	.byte	0x9f
	.long	.LVL82-.Ltext0
	.long	.LVL83-.Ltext0
	.value	0x8
	.byte	0x73
	.sleb128 24
	.byte	0x6
	.byte	0x23
	.uleb128 0x1ffffc
	.byte	0x9f
	.long	0
	.long	0
.LLST25:
	.long	.LVL88-.Ltext0
	.long	.LVL89-.Ltext0
	.value	0x6
	.byte	0x72
	.sleb128 2097148
	.byte	0x9f
	.long	.LVL89-.Ltext0
	.long	.LVL90-.Ltext0
	.value	0x6
	.byte	0x72
	.sleb128 2097144
	.byte	0x9f
	.long	.LVL90-.Ltext0
	.long	.LVL91-.Ltext0
	.value	0x3
	.byte	0x72
	.sleb128 4
	.byte	0x9f
	.long	0
	.long	0
.LLST26:
	.long	.LVL86-.Ltext0
	.long	.LVL87-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL92-.Ltext0
	.long	.LFE45-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST27:
	.long	.LVL86-.Ltext0
	.long	.LVL87-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL92-.Ltext0
	.long	.LFE45-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST29:
	.long	.LVL112-.Ltext0
	.long	.LVL121-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL121-.Ltext0
	.long	.LVL122-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL122-.Ltext0
	.long	.LVL123-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL123-.Ltext0
	.long	.LVL124-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL124-.Ltext0
	.long	.LVL127-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST30:
	.long	.LVL95-.Ltext0
	.long	.LVL102-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL140-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST31:
	.long	.LVL95-.Ltext0
	.long	.LVL102-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL140-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST32:
	.long	.LVL96-.Ltext0
	.long	.LVL102-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL140-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST33:
	.long	.LVL98-.Ltext0
	.long	.LVL99-.Ltext0
	.value	0x6
	.byte	0x70
	.sleb128 2097148
	.byte	0x9f
	.long	.LVL99-.Ltext0
	.long	.LVL100-.Ltext0
	.value	0x6
	.byte	0x70
	.sleb128 2097144
	.byte	0x9f
	.long	.LVL100-.Ltext0
	.long	.LVL101-.Ltext0
	.value	0x3
	.byte	0x70
	.sleb128 4
	.byte	0x9f
	.long	0
	.long	0
.LLST34:
	.long	.LVL96-.Ltext0
	.long	.LVL97-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL140-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST35:
	.long	.LVL96-.Ltext0
	.long	.LVL97-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL140-.Ltext0
	.long	.LFE48-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST37:
	.long	.LVL103-.Ltext0
	.long	.LVL111-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	0
	.long	0
.LLST38:
	.long	.LVL103-.Ltext0
	.long	.LVL111-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST39:
	.long	.LVL103-.Ltext0
	.long	.LVL111-.Ltext0
	.value	0x2
	.byte	0x31
	.byte	0x9f
	.long	0
	.long	0
.LLST40:
	.long	.LVL105-.Ltext0
	.long	.LVL106-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL106-.Ltext0
	.long	.LVL111-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST41:
	.long	.LVL107-.Ltext0
	.long	.LVL108-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL108-.Ltext0
	.long	.LVL109-.Ltext0
	.value	0x6
	.byte	0x70
	.sleb128 2097148
	.byte	0x9f
	.long	.LVL109-.Ltext0
	.long	.LVL110-.Ltext0
	.value	0x8
	.byte	0x73
	.sleb128 24
	.byte	0x6
	.byte	0x23
	.uleb128 0x1ffffc
	.byte	0x9f
	.long	0
	.long	0
.LLST42:
	.long	.LVL112-.Ltext0
	.long	.LVL113-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL124-.Ltext0
	.long	.LVL125-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST43:
	.long	.LVL112-.Ltext0
	.long	.LVL113-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL124-.Ltext0
	.long	.LVL125-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST44:
	.long	.LVL114-.Ltext0
	.long	.LVL118-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL126-.Ltext0
	.long	.LVL127-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST45:
	.long	.LVL114-.Ltext0
	.long	.LVL115-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	.LVL115-.Ltext0
	.long	.LVL116-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 8
	.long	.LVL116-.Ltext0
	.long	.LVL117-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL126-.Ltext0
	.long	.LVL127-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	0
	.long	0
.LLST46:
	.long	.LVL119-.Ltext0
	.long	.LVL120-.Ltext0
	.value	0x9
	.byte	0x3
	.long	current_thread
	.byte	0x6
	.byte	0x23
	.uleb128 0x20
	.byte	0x9f
	.long	0
	.long	0
.LLST47:
	.long	.LVL128-.Ltext0
	.long	.LVL132-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST50:
	.long	.LVL130-.Ltext0
	.long	.LVL131-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL131-.Ltext0
	.long	.LVL132-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST51:
	.long	.LVL134-.Ltext0
	.long	.LVL135-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST52:
	.long	.LVL136-.Ltext0
	.long	.LVL137-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST53:
	.long	.LVL138-.Ltext0
	.long	.LVL139-.Ltext0
	.value	0x1
	.byte	0x57
	.long	0
	.long	0
.LLST54:
	.long	.LVL141-.Ltext0
	.long	.LVL159-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL159-.Ltext0
	.long	.LVL160-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL160-.Ltext0
	.long	.LFE49-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST55:
	.long	.LVL142-.Ltext0
	.long	.LVL146-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL157-.Ltext0
	.long	.LVL159-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL166-.Ltext0
	.long	.LVL168-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL173-.Ltext0
	.long	.LVL176-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST56:
	.long	.LVL142-.Ltext0
	.long	.LVL146-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL157-.Ltext0
	.long	.LVL159-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL166-.Ltext0
	.long	.LVL168-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL173-.Ltext0
	.long	.LVL176-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST57:
	.long	.LVL143-.Ltext0
	.long	.LVL144-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL144-.Ltext0
	.long	.LVL146-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL157-.Ltext0
	.long	.LVL158-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL166-.Ltext0
	.long	.LVL167-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL174-.Ltext0
	.long	.LVL175-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST58:
	.long	.LVL147-.Ltext0
	.long	.LVL148-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL155-.Ltext0
	.long	.LVL156-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST59:
	.long	.LVL147-.Ltext0
	.long	.LVL148-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL155-.Ltext0
	.long	.LVL156-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST60:
	.long	.LVL149-.Ltext0
	.long	.LVL153-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST61:
	.long	.LVL149-.Ltext0
	.long	.LVL150-.Ltext0
	.value	0x2
	.byte	0x71
	.sleb128 0
	.long	.LVL150-.Ltext0
	.long	.LVL151-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 8
	.long	.LVL151-.Ltext0
	.long	.LVL152-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST62:
	.long	.LVL160-.Ltext0
	.long	.LVL164-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL169-.Ltext0
	.long	.LVL173-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL176-.Ltext0
	.long	.LFE49-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST63:
	.long	.LVL160-.Ltext0
	.long	.LVL164-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL169-.Ltext0
	.long	.LVL173-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL176-.Ltext0
	.long	.LFE49-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST64:
	.long	.LVL161-.Ltext0
	.long	.LVL162-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL162-.Ltext0
	.long	.LVL164-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL169-.Ltext0
	.long	.LVL170-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL171-.Ltext0
	.long	.LVL172-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL177-.Ltext0
	.long	.LVL178-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST65:
	.long	.LVL165-.Ltext0
	.long	.LVL166-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL168-.Ltext0
	.long	.LVL169-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST66:
	.long	.LVL165-.Ltext0
	.long	.LVL166-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL168-.Ltext0
	.long	.LVL169-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST67:
	.long	.LVL180-.Ltext0
	.long	.LVL185-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL204-.Ltext0
	.long	.LVL206-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL222-.Ltext0
	.long	.LVL223-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL228-.Ltext0
	.long	.LVL231-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST68:
	.long	.LVL180-.Ltext0
	.long	.LVL185-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL204-.Ltext0
	.long	.LVL206-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL222-.Ltext0
	.long	.LVL223-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL228-.Ltext0
	.long	.LVL231-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST69:
	.long	.LVL181-.Ltext0
	.long	.LVL182-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL182-.Ltext0
	.long	.LVL184-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL204-.Ltext0
	.long	.LVL205-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL222-.Ltext0
	.long	.LVL223-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL229-.Ltext0
	.long	.LVL230-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST70:
	.long	.LVL185-.Ltext0
	.long	.LVL186-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL206-.Ltext0
	.long	.LVL207-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL223-.Ltext0
	.long	.LVL224-.Ltext0
	.value	0x1
	.byte	0x56
	.long	.LVL237-.Ltext0
	.long	.LVL238-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST71:
	.long	.LVL185-.Ltext0
	.long	.LVL186-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL206-.Ltext0
	.long	.LVL207-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL223-.Ltext0
	.long	.LVL224-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL237-.Ltext0
	.long	.LVL238-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST72:
	.long	.LVL186-.Ltext0
	.long	.LVL191-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL198-.Ltext0
	.long	.LVL203-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL220-.Ltext0
	.long	.LVL221-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL227-.Ltext0
	.long	.LVL228-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL231-.Ltext0
	.long	.LVL233-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST73:
	.long	.LVL186-.Ltext0
	.long	.LVL191-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL198-.Ltext0
	.long	.LVL203-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL220-.Ltext0
	.long	.LVL221-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL227-.Ltext0
	.long	.LVL228-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL231-.Ltext0
	.long	.LVL233-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST74:
	.long	.LVL186-.Ltext0
	.long	.LVL187-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	.LVL187-.Ltext0
	.long	.LVL190-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL198-.Ltext0
	.long	.LVL199-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL199-.Ltext0
	.long	.LVL200-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 0
	.long	.LVL200-.Ltext0
	.long	.LVL201-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL201-.Ltext0
	.long	.LVL202-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 0
	.long	.LVL220-.Ltext0
	.long	.LVL221-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	.LVL231-.Ltext0
	.long	.LVL232-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL232-.Ltext0
	.long	.LVL233-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 0
	.long	0
	.long	0
.LLST75:
	.long	.LVL191-.Ltext0
	.long	.LVL192-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL203-.Ltext0
	.long	.LVL204-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL221-.Ltext0
	.long	.LVL222-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST76:
	.long	.LVL191-.Ltext0
	.long	.LVL192-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL203-.Ltext0
	.long	.LVL204-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL221-.Ltext0
	.long	.LVL222-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST77:
	.long	.LVL193-.Ltext0
	.long	.LVL195-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST78:
	.long	.LVL193-.Ltext0
	.long	.LVL194-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	0
	.long	0
.LLST79:
	.long	.LVL215-.Ltext0
	.long	.LVL219-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST80:
	.long	.LVL215-.Ltext0
	.long	.LVL216-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	.LVL216-.Ltext0
	.long	.LVL217-.Ltext0
	.value	0x2
	.byte	0x70
	.sleb128 8
	.long	.LVL217-.Ltext0
	.long	.LVL218-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST81:
	.long	.LVL208-.Ltext0
	.long	.LVL213-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL224-.Ltext0
	.long	.LVL226-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL233-.Ltext0
	.long	.LVL234-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL235-.Ltext0
	.long	.LVL237-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST82:
	.long	.LVL208-.Ltext0
	.long	.LVL213-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL224-.Ltext0
	.long	.LVL226-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL233-.Ltext0
	.long	.LVL234-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL235-.Ltext0
	.long	.LVL237-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST83:
	.long	.LVL209-.Ltext0
	.long	.LVL210-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL210-.Ltext0
	.long	.LVL212-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL224-.Ltext0
	.long	.LVL225-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL233-.Ltext0
	.long	.LVL234-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL236-.Ltext0
	.long	.LVL237-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST84:
	.long	.LVL213-.Ltext0
	.long	.LVL214-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL226-.Ltext0
	.long	.LVL227-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL234-.Ltext0
	.long	.LVL235-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL238-.Ltext0
	.long	.LFE51-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST85:
	.long	.LVL213-.Ltext0
	.long	.LVL214-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL226-.Ltext0
	.long	.LVL227-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL234-.Ltext0
	.long	.LVL235-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL238-.Ltext0
	.long	.LFE51-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST86:
	.long	.LVL239-.Ltext0
	.long	.LVL242-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL242-.Ltext0
	.long	.LVL243-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL243-.Ltext0
	.long	.LVL256-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL257-.Ltext0
	.long	.LVL262-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL262-.Ltext0
	.long	.LVL276-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL276-.Ltext0
	.long	.LVL277-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL277-.Ltext0
	.long	.LVL278-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL278-.Ltext0
	.long	.LVL280-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL280-.Ltext0
	.long	.LVL283-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL283-.Ltext0
	.long	.LFE52-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST87:
	.long	.LVL240-.Ltext0
	.long	.LVL247-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL257-.Ltext0
	.long	.LVL259-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL275-.Ltext0
	.long	.LVL276-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL278-.Ltext0
	.long	.LVL280-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST88:
	.long	.LVL240-.Ltext0
	.long	.LVL247-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL257-.Ltext0
	.long	.LVL259-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL275-.Ltext0
	.long	.LVL276-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL278-.Ltext0
	.long	.LVL280-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST89:
	.long	.LVL241-.Ltext0
	.long	.LVL244-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL244-.Ltext0
	.long	.LVL246-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL257-.Ltext0
	.long	.LVL258-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL275-.Ltext0
	.long	.LVL276-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL279-.Ltext0
	.long	.LVL280-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST90:
	.long	.LVL247-.Ltext0
	.long	.LVL248-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL259-.Ltext0
	.long	.LVL260-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL276-.Ltext0
	.long	.LVL277-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL283-.Ltext0
	.long	.LFE52-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST91:
	.long	.LVL247-.Ltext0
	.long	.LVL248-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL259-.Ltext0
	.long	.LVL260-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL276-.Ltext0
	.long	.LVL277-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL283-.Ltext0
	.long	.LFE52-.Ltext0
	.value	0x1
	.byte	0x51
	.long	0
	.long	0
.LLST92:
	.long	.LVL248-.Ltext0
	.long	.LVL252-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	.LVL261-.Ltext0
	.long	.LVL262-.Ltext0
	.value	0x5
	.byte	0x3
	.long	valid_queue
	.long	0
	.long	0
.LLST93:
	.long	.LVL248-.Ltext0
	.long	.LVL249-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	.LVL249-.Ltext0
	.long	.LVL251-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL261-.Ltext0
	.long	.LVL262-.Ltext0
	.value	0x6
	.byte	0x3
	.long	valid_queue
	.byte	0x6
	.long	0
	.long	0
.LLST94:
	.long	.LVL253-.Ltext0
	.long	.LVL254-.Ltext0
	.value	0x3
	.byte	0x70
	.sleb128 32
	.byte	0x9f
	.long	0
	.long	0
.LLST95:
	.long	.LVL253-.Ltext0
	.long	.LVL254-.Ltext0
	.value	0x9
	.byte	0x3
	.long	current_thread
	.byte	0x6
	.byte	0x23
	.uleb128 0x20
	.byte	0x9f
	.long	0
	.long	0
.LLST96:
	.long	.LVL263-.Ltext0
	.long	.LVL267-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL271-.Ltext0
	.long	.LVL275-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL280-.Ltext0
	.long	.LVL283-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST97:
	.long	.LVL263-.Ltext0
	.long	.LVL267-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL271-.Ltext0
	.long	.LVL275-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL280-.Ltext0
	.long	.LVL283-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST98:
	.long	.LVL264-.Ltext0
	.long	.LVL265-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL265-.Ltext0
	.long	.LVL267-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL271-.Ltext0
	.long	.LVL272-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL273-.Ltext0
	.long	.LVL274-.Ltext0
	.value	0x1
	.byte	0x51
	.long	.LVL281-.Ltext0
	.long	.LVL282-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST99:
	.long	.LVL268-.Ltext0
	.long	.LVL269-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL270-.Ltext0
	.long	.LVL271-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST100:
	.long	.LVL268-.Ltext0
	.long	.LVL269-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL270-.Ltext0
	.long	.LVL271-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST101:
	.long	.LVL284-.Ltext0
	.long	.LVL288-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	0
	.long	0
.LLST104:
	.long	.LVL286-.Ltext0
	.long	.LVL287-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL287-.Ltext0
	.long	.LVL288-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST105:
	.long	.LVL290-.Ltext0
	.long	.LVL291-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST106:
	.long	.LVL292-.Ltext0
	.long	.LVL293-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST107:
	.long	.LVL294-.Ltext0
	.long	.LVL295-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST108:
	.long	.LVL299-.Ltext0
	.long	.LVL303-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST109:
	.long	.LVL297-.Ltext0
	.long	.LVL298-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC16
	.byte	0x9f
	.long	0
	.long	0
.LLST110:
	.long	.LVL300-.Ltext0
	.long	.LVL301-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC17
	.byte	0x9f
	.long	0
	.long	0
.LLST111:
	.long	.LVL306-.Ltext0
	.long	.LVL310-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST112:
	.long	.LVL304-.Ltext0
	.long	.LVL305-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC19
	.byte	0x9f
	.long	0
	.long	0
.LLST113:
	.long	.LVL307-.Ltext0
	.long	.LVL308-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC20
	.byte	0x9f
	.long	0
	.long	0
.LLST114:
	.long	.LVL313-.Ltext0
	.long	.LVL317-.Ltext0
	.value	0x1
	.byte	0x53
	.long	0
	.long	0
.LLST115:
	.long	.LVL311-.Ltext0
	.long	.LVL312-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC22
	.byte	0x9f
	.long	0
	.long	0
.LLST116:
	.long	.LVL314-.Ltext0
	.long	.LVL315-.Ltext0
	.value	0x6
	.byte	0x3
	.long	.LC23
	.byte	0x9f
	.long	0
	.long	0
.LLST117:
	.long	.LVL318-.Ltext0
	.long	.LVL323-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL323-.Ltext0
	.long	.LVL324-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL324-.Ltext0
	.long	.LVL325-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL325-.Ltext0
	.long	.LVL326-.Ltext0
	.value	0x1
	.byte	0x53
	.long	.LVL326-.Ltext0
	.long	.LFE58-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	0
	.long	0
.LLST118:
	.long	.LVL319-.Ltext0
	.long	.LVL321-.Ltext0
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.long	.LVL322-.Ltext0
	.long	.LVL323-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST119:
	.long	.LVL320-.Ltext0
	.long	.LVL321-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL322-.Ltext0
	.long	.LVL325-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.LBB59-.Ltext0
	.long	.LBE59-.Ltext0
	.long	.LBB96-.Ltext0
	.long	.LBE96-.Ltext0
	.long	.LBB97-.Ltext0
	.long	.LBE97-.Ltext0
	.long	.LBB98-.Ltext0
	.long	.LBE98-.Ltext0
	.long	0
	.long	0
	.long	.LBB61-.Ltext0
	.long	.LBE61-.Ltext0
	.long	.LBB80-.Ltext0
	.long	.LBE80-.Ltext0
	.long	.LBB88-.Ltext0
	.long	.LBE88-.Ltext0
	.long	.LBB91-.Ltext0
	.long	.LBE91-.Ltext0
	.long	0
	.long	0
	.long	.LBB66-.Ltext0
	.long	.LBE66-.Ltext0
	.long	.LBB78-.Ltext0
	.long	.LBE78-.Ltext0
	.long	0
	.long	0
	.long	.LBB69-.Ltext0
	.long	.LBE69-.Ltext0
	.long	.LBB79-.Ltext0
	.long	.LBE79-.Ltext0
	.long	0
	.long	0
	.long	.LBB71-.Ltext0
	.long	.LBE71-.Ltext0
	.long	.LBB74-.Ltext0
	.long	.LBE74-.Ltext0
	.long	0
	.long	0
	.long	.LBB81-.Ltext0
	.long	.LBE81-.Ltext0
	.long	.LBB90-.Ltext0
	.long	.LBE90-.Ltext0
	.long	.LBB92-.Ltext0
	.long	.LBE92-.Ltext0
	.long	0
	.long	0
	.long	.LBB85-.Ltext0
	.long	.LBE85-.Ltext0
	.long	.LBB89-.Ltext0
	.long	.LBE89-.Ltext0
	.long	0
	.long	0
	.long	.LBB103-.Ltext0
	.long	.LBE103-.Ltext0
	.long	.LBB107-.Ltext0
	.long	.LBE107-.Ltext0
	.long	.LBB108-.Ltext0
	.long	.LBE108-.Ltext0
	.long	0
	.long	0
	.long	.LBB115-.Ltext0
	.long	.LBE115-.Ltext0
	.long	.LBB119-.Ltext0
	.long	.LBE119-.Ltext0
	.long	.LBB120-.Ltext0
	.long	.LBE120-.Ltext0
	.long	0
	.long	0
	.long	.LBB149-.Ltext0
	.long	.LBE149-.Ltext0
	.long	.LBB211-.Ltext0
	.long	.LBE211-.Ltext0
	.long	0
	.long	0
	.long	.LBB151-.Ltext0
	.long	.LBE151-.Ltext0
	.long	.LBB154-.Ltext0
	.long	.LBE154-.Ltext0
	.long	0
	.long	0
	.long	.LBB159-.Ltext0
	.long	.LBE159-.Ltext0
	.long	.LBB177-.Ltext0
	.long	.LBE177-.Ltext0
	.long	.LBB181-.Ltext0
	.long	.LBE181-.Ltext0
	.long	.LBB183-.Ltext0
	.long	.LBE183-.Ltext0
	.long	0
	.long	0
	.long	.LBB164-.Ltext0
	.long	.LBE164-.Ltext0
	.long	.LBB178-.Ltext0
	.long	.LBE178-.Ltext0
	.long	.LBB179-.Ltext0
	.long	.LBE179-.Ltext0
	.long	.LBB180-.Ltext0
	.long	.LBE180-.Ltext0
	.long	.LBB182-.Ltext0
	.long	.LBE182-.Ltext0
	.long	.LBB184-.Ltext0
	.long	.LBE184-.Ltext0
	.long	0
	.long	0
	.long	.LBB166-.Ltext0
	.long	.LBE166-.Ltext0
	.long	.LBB169-.Ltext0
	.long	.LBE169-.Ltext0
	.long	0
	.long	0
	.long	.LBB187-.Ltext0
	.long	.LBE187-.Ltext0
	.long	.LBB190-.Ltext0
	.long	.LBE190-.Ltext0
	.long	0
	.long	0
	.long	.LBB191-.Ltext0
	.long	.LBE191-.Ltext0
	.long	.LBB197-.Ltext0
	.long	.LBE197-.Ltext0
	.long	0
	.long	0
	.long	.LBB194-.Ltext0
	.long	.LBE194-.Ltext0
	.long	.LBB198-.Ltext0
	.long	.LBE198-.Ltext0
	.long	0
	.long	0
	.long	.LBB199-.Ltext0
	.long	.LBE199-.Ltext0
	.long	.LBB207-.Ltext0
	.long	.LBE207-.Ltext0
	.long	.LBB209-.Ltext0
	.long	.LBE209-.Ltext0
	.long	0
	.long	0
	.long	.LBB203-.Ltext0
	.long	.LBE203-.Ltext0
	.long	.LBB208-.Ltext0
	.long	.LBE208-.Ltext0
	.long	.LBB210-.Ltext0
	.long	.LBE210-.Ltext0
	.long	0
	.long	0
	.long	.LBB226-.Ltext0
	.long	.LBE226-.Ltext0
	.long	.LBB245-.Ltext0
	.long	.LBE245-.Ltext0
	.long	.LBB253-.Ltext0
	.long	.LBE253-.Ltext0
	.long	.LBB256-.Ltext0
	.long	.LBE256-.Ltext0
	.long	0
	.long	0
	.long	.LBB231-.Ltext0
	.long	.LBE231-.Ltext0
	.long	.LBB243-.Ltext0
	.long	.LBE243-.Ltext0
	.long	0
	.long	0
	.long	.LBB234-.Ltext0
	.long	.LBE234-.Ltext0
	.long	.LBB244-.Ltext0
	.long	.LBE244-.Ltext0
	.long	0
	.long	0
	.long	.LBB236-.Ltext0
	.long	.LBE236-.Ltext0
	.long	.LBB239-.Ltext0
	.long	.LBE239-.Ltext0
	.long	0
	.long	0
	.long	.LBB246-.Ltext0
	.long	.LBE246-.Ltext0
	.long	.LBB255-.Ltext0
	.long	.LBE255-.Ltext0
	.long	.LBB257-.Ltext0
	.long	.LBE257-.Ltext0
	.long	0
	.long	0
	.long	.LBB250-.Ltext0
	.long	.LBE250-.Ltext0
	.long	.LBB254-.Ltext0
	.long	.LBE254-.Ltext0
	.long	0
	.long	0
	.long	.LBB282-.Ltext0
	.long	.LBE282-.Ltext0
	.long	.LBB335-.Ltext0
	.long	.LBE335-.Ltext0
	.long	.LBB337-.Ltext0
	.long	.LBE337-.Ltext0
	.long	.LBB356-.Ltext0
	.long	.LBE356-.Ltext0
	.long	.LBB363-.Ltext0
	.long	.LBE363-.Ltext0
	.long	0
	.long	0
	.long	.LBB288-.Ltext0
	.long	.LBE288-.Ltext0
	.long	.LBB302-.Ltext0
	.long	.LBE302-.Ltext0
	.long	.LBB336-.Ltext0
	.long	.LBE336-.Ltext0
	.long	.LBB338-.Ltext0
	.long	.LBE338-.Ltext0
	.long	.LBB357-.Ltext0
	.long	.LBE357-.Ltext0
	.long	0
	.long	0
	.long	.LBB294-.Ltext0
	.long	.LBE294-.Ltext0
	.long	.LBB303-.Ltext0
	.long	.LBE303-.Ltext0
	.long	.LBB331-.Ltext0
	.long	.LBE331-.Ltext0
	.long	.LBB333-.Ltext0
	.long	.LBE333-.Ltext0
	.long	.LBB354-.Ltext0
	.long	.LBE354-.Ltext0
	.long	.LBB362-.Ltext0
	.long	.LBE362-.Ltext0
	.long	.LBB364-.Ltext0
	.long	.LBE364-.Ltext0
	.long	0
	.long	0
	.long	.LBB304-.Ltext0
	.long	.LBE304-.Ltext0
	.long	.LBB320-.Ltext0
	.long	.LBE320-.Ltext0
	.long	.LBB332-.Ltext0
	.long	.LBE332-.Ltext0
	.long	.LBB334-.Ltext0
	.long	.LBE334-.Ltext0
	.long	.LBB355-.Ltext0
	.long	.LBE355-.Ltext0
	.long	0
	.long	0
	.long	.LBB310-.Ltext0
	.long	.LBE310-.Ltext0
	.long	.LBB321-.Ltext0
	.long	.LBE321-.Ltext0
	.long	.LBB330-.Ltext0
	.long	.LBE330-.Ltext0
	.long	0
	.long	0
	.long	.LBB312-.Ltext0
	.long	.LBE312-.Ltext0
	.long	.LBB315-.Ltext0
	.long	.LBE315-.Ltext0
	.long	0
	.long	0
	.long	.LBB322-.Ltext0
	.long	.LBE322-.Ltext0
	.long	.LBB351-.Ltext0
	.long	.LBE351-.Ltext0
	.long	.LBB353-.Ltext0
	.long	.LBE353-.Ltext0
	.long	0
	.long	0
	.long	.LBB324-.Ltext0
	.long	.LBE324-.Ltext0
	.long	.LBB327-.Ltext0
	.long	.LBE327-.Ltext0
	.long	0
	.long	0
	.long	.LBB339-.Ltext0
	.long	.LBE339-.Ltext0
	.long	.LBB358-.Ltext0
	.long	.LBE358-.Ltext0
	.long	.LBB360-.Ltext0
	.long	.LBE360-.Ltext0
	.long	.LBB365-.Ltext0
	.long	.LBE365-.Ltext0
	.long	.LBB367-.Ltext0
	.long	.LBE367-.Ltext0
	.long	0
	.long	0
	.long	.LBB345-.Ltext0
	.long	.LBE345-.Ltext0
	.long	.LBB352-.Ltext0
	.long	.LBE352-.Ltext0
	.long	.LBB359-.Ltext0
	.long	.LBE359-.Ltext0
	.long	.LBB361-.Ltext0
	.long	.LBE361-.Ltext0
	.long	.LBB366-.Ltext0
	.long	.LBE366-.Ltext0
	.long	0
	.long	0
	.long	.LBB382-.Ltext0
	.long	.LBE382-.Ltext0
	.long	.LBB410-.Ltext0
	.long	.LBE410-.Ltext0
	.long	.LBB412-.Ltext0
	.long	.LBE412-.Ltext0
	.long	.LBB426-.Ltext0
	.long	.LBE426-.Ltext0
	.long	.LBB428-.Ltext0
	.long	.LBE428-.Ltext0
	.long	0
	.long	0
	.long	.LBB388-.Ltext0
	.long	.LBE388-.Ltext0
	.long	.LBB407-.Ltext0
	.long	.LBE407-.Ltext0
	.long	.LBB411-.Ltext0
	.long	.LBE411-.Ltext0
	.long	.LBB413-.Ltext0
	.long	.LBE413-.Ltext0
	.long	.LBB415-.Ltext0
	.long	.LBE415-.Ltext0
	.long	.LBB427-.Ltext0
	.long	.LBE427-.Ltext0
	.long	0
	.long	0
	.long	.LBB395-.Ltext0
	.long	.LBE395-.Ltext0
	.long	.LBB408-.Ltext0
	.long	.LBE408-.Ltext0
	.long	.LBB409-.Ltext0
	.long	.LBE409-.Ltext0
	.long	.LBB414-.Ltext0
	.long	.LBE414-.Ltext0
	.long	.LBB416-.Ltext0
	.long	.LBE416-.Ltext0
	.long	0
	.long	0
	.long	.LBB397-.Ltext0
	.long	.LBE397-.Ltext0
	.long	.LBB400-.Ltext0
	.long	.LBE400-.Ltext0
	.long	0
	.long	0
	.long	.LBB417-.Ltext0
	.long	.LBE417-.Ltext0
	.long	.LBB425-.Ltext0
	.long	.LBE425-.Ltext0
	.long	.LBB429-.Ltext0
	.long	.LBE429-.Ltext0
	.long	0
	.long	0
	.long	.LBB421-.Ltext0
	.long	.LBE421-.Ltext0
	.long	.LBB424-.Ltext0
	.long	.LBE424-.Ltext0
	.long	0
	.long	0
	.long	.LBB445-.Ltext0
	.long	.LBE445-.Ltext0
	.long	.LBB453-.Ltext0
	.long	.LBE453-.Ltext0
	.long	.LBB454-.Ltext0
	.long	.LBE454-.Ltext0
	.long	0
	.long	0
	.long	.LBB449-.Ltext0
	.long	.LBE449-.Ltext0
	.long	.LBB455-.Ltext0
	.long	.LBE455-.Ltext0
	.long	.LBB459-.Ltext0
	.long	.LBE459-.Ltext0
	.long	0
	.long	0
	.long	.LBB456-.Ltext0
	.long	.LBE456-.Ltext0
	.long	.LBB460-.Ltext0
	.long	.LBE460-.Ltext0
	.long	0
	.long	0
	.long	.LBB461-.Ltext0
	.long	.LBE461-.Ltext0
	.long	.LBB468-.Ltext0
	.long	.LBE468-.Ltext0
	.long	0
	.long	0
	.long	.LBB464-.Ltext0
	.long	.LBE464-.Ltext0
	.long	.LBB469-.Ltext0
	.long	.LBE469-.Ltext0
	.long	.LBB470-.Ltext0
	.long	.LBE470-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF102:
	.string	"printf"
.LASF10:
	.string	"__off_t"
.LASF16:
	.string	"_IO_read_ptr"
.LASF117:
	.string	"malloc"
.LASF28:
	.string	"_chain"
.LASF8:
	.string	"size_t"
.LASF50:
	.string	"lwt_fn_t"
.LASF34:
	.string	"_shortbuf"
.LASF126:
	.string	"lwt_current"
.LASF49:
	.string	"t_id"
.LASF61:
	.string	"prev"
.LASF89:
	.string	"__remove_from_queue"
.LASF64:
	.string	"init_sp"
.LASF22:
	.string	"_IO_buf_base"
.LASF7:
	.string	"long long unsigned int"
.LASF96:
	.string	"next_thread"
.LASF60:
	.string	"next"
.LASF110:
	.string	"lwt_counter"
.LASF71:
	.string	"node_count"
.LASF6:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF72:
	.string	"linked_list"
.LASF54:
	.string	"lwt_info_t"
.LASF29:
	.string	"_fileno"
.LASF17:
	.string	"_IO_read_end"
.LASF80:
	.string	"list"
.LASF53:
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
.LASF118:
	.string	"__printf_chk"
.LASF81:
	.string	"__add_to_head"
.LASF31:
	.string	"_old_offset"
.LASF36:
	.string	"_offset"
.LASF79:
	.string	"__init_list"
.LASF123:
	.string	"_lwt_info_t"
.LASF57:
	.string	"_lwt_t"
.LASF56:
	.string	"lwt_context"
.LASF45:
	.string	"_IO_marker"
.LASF108:
	.string	"stdin"
.LASF52:
	.string	"LWT_INFO_NTHD_BLOCKED"
.LASF0:
	.string	"unsigned int"
.LASF93:
	.string	"__lwt_trampoline"
.LASF3:
	.string	"long unsigned int"
.LASF20:
	.string	"_IO_write_ptr"
.LASF47:
	.string	"_sbuf"
.LASF85:
	.string	"data"
.LASF2:
	.string	"short unsigned int"
.LASF114:
	.string	"zombie_queue"
.LASF58:
	.string	"lwt_id"
.LASF121:
	.string	"/root/works/lwt-v1-sudo-rm-rf"
.LASF24:
	.string	"_IO_save_base"
.LASF75:
	.string	"__get_active_thread"
.LASF125:
	.string	"__initiate"
.LASF35:
	.string	"_lock"
.LASF30:
	.string	"_flags2"
.LASF42:
	.string	"_mode"
.LASF109:
	.string	"stdout"
.LASF105:
	.string	"print_recycle_thread_info"
.LASF70:
	.string	"tail"
.LASF13:
	.string	"sizetype"
.LASF120:
	.string	"lwt.c"
.LASF95:
	.string	"return_message"
.LASF87:
	.string	"lwt_die"
.LASF62:
	.string	"merge_to"
.LASF119:
	.string	"GNU C11 5.3.1 20160413 -mtune=generic -march=i686 -g -O3 -fstack-protector-strong"
.LASF88:
	.string	"message"
.LASF122:
	.string	"_IO_lock_t"
.LASF44:
	.string	"_IO_FILE"
.LASF115:
	.string	"current_thread"
.LASF63:
	.string	"wait_merge"
.LASF104:
	.string	"current"
.LASF48:
	.string	"_pos"
.LASF101:
	.string	"input_thread"
.LASF27:
	.string	"_markers"
.LASF107:
	.string	"lwt_info"
.LASF55:
	.string	"_lwt_context"
.LASF77:
	.string	"thread"
.LASF1:
	.string	"unsigned char"
.LASF74:
	.string	"curr"
.LASF106:
	.string	"print_zombie_thread_info"
.LASF103:
	.string	"print_living_thread_info"
.LASF5:
	.string	"short int"
.LASF78:
	.string	"__lwt_dispatch"
.LASF97:
	.string	"lwt_yield"
.LASF98:
	.string	"strong_thread"
.LASF65:
	.string	"last_word"
.LASF112:
	.string	"valid_queue"
.LASF116:
	.string	"old_thread"
.LASF33:
	.string	"_vtable_offset"
.LASF94:
	.string	"lwt_create"
.LASF76:
	.string	"__add_to_tail"
.LASF99:
	.string	"lwt_join"
.LASF69:
	.string	"head"
.LASF86:
	.string	"created_thread"
.LASF14:
	.string	"char"
.LASF92:
	.string	"reused_thread"
.LASF90:
	.string	"tmp_thread"
.LASF83:
	.string	"__create_thread"
.LASF68:
	.string	"_linked_list"
.LASF111:
	.string	"thread_initiated"
.LASF46:
	.string	"_next"
.LASF12:
	.string	"__off64_t"
.LASF18:
	.string	"_IO_read_base"
.LASF26:
	.string	"_IO_save_end"
.LASF66:
	.string	"context"
.LASF82:
	.string	"__fmt"
.LASF73:
	.string	"thread_queue"
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
.LASF124:
	.string	"__lwt_schedule"
.LASF21:
	.string	"_IO_write_end"
.LASF43:
	.string	"_unused2"
.LASF59:
	.string	"status"
.LASF113:
	.string	"recycle_queue"
.LASF91:
	.string	"__reuse_thread"
.LASF100:
	.string	"thread_to_wait"
.LASF25:
	.string	"_IO_backup_base"
.LASF84:
	.string	"with_stack"
.LASF51:
	.string	"LWT_INFO_NTHD_RUNNABLE"
.LASF19:
	.string	"_IO_write_base"
.LASF67:
	.string	"lwt_t"
	.ident	"GCC: (Ubuntu 5.3.1-14ubuntu2) 5.3.1 20160413"
	.section	.note.GNU-stack,"",@progbits
