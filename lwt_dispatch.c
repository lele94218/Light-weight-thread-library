#include <stdio.h>
#include <stdlib.h>
#include "lwt.h"

/* pause one thread, start executing the next one */
inline void __lwt_dispatch(lwt_context *curr, lwt_context *next)
{
__asm__ __volatile
	(
	//"push %edi\n\t"
        //"push %esi\n\t"
	//"push %ebx\n\t"
	"mov 0xc(%ebp),%eax\n\t"
	"mov 0x4(%eax),%ecx\n\t"
	"mov (%eax),%edx\n\t"
	"mov 0x8(%ebp),%eax\n\t"
	"add $0x4,%eax\n\t"
	"mov 0x8(%ebp),%ebx\n\t"
	"push %ebp\n\t"
	//"push %eax\n\t"
	"push %ebx\n\t"
	//"push %ecx\n\t"
	//"push %edx\n\t"
	"mov %esp,(%eax)\n\t"
	"movl $label_1,(%ebx)\n\t"
	"mov %ecx,%esp\n\t"
	"jmp *%edx\n\t"
	//"return: pop %edx\n\t"
	//"pop %ecx\n\t"
	"label_1:"
	"pop %ebx\n\t"
	//"pop %eax\n\t"
	"pop %ebp\n\t"
	//"pop %ebx\n\t"
	//"pop %esi\n\t"
	//"pop %edi\n\t"
	);
}

