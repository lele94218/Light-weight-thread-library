#include "lwt_dispatch.h"

void __lwt_dispatch(lwt_context *curr, lwt_context *next)
{
__asm__(
	"push %edi\n\t"
        "push %esi\n\t"
	"push %ebx\n\t"
	"mov 0xc(%ebp),%eax\n\t"
	"mov 0x4(%eax),%ecx\n\t"
	"mov 0xc(%ebp),%eax\n\t"
	"mov (%eax),%edx\n\t"
	"mov 0x8(%ebp),%eax\n\t"
	"add $0x4,%eax\n\t"
	"mov 0x8(%ebp),%ebx\n\t"
	
	"push %ebp\n\t"
	"push %eax\n\t"
	"push %ebx\n\t"
	"push %ecx\n\t"
	"push %edx\n\t"
	"mov %esp,(%eax)\n\t"
	"movl $0x2b,(%ebx)\n\t"
	"mov %ecx,%esp\n\t"
	"jmp *%edx\n\t"
	"pop %edx\n\t"
	"pop %ecx\n\t"
	"pop %ebx\n\t"
	"pop %eax\n\t"
	"pop %ebp\n\t"
	"pop %ebx\n\t"
	"pop %esi\n\t"
	"pop %edi\n\t"

);
}
/*
	"mov 0xc(%ebp),%edx\n\t"
	"mov 0x4(%edx),%ecx\n\t"
	"mov 0x8(%ebp),%eax\n\t"
	"add $0x4,%eax\n\t"
	"mov 0x8(%ebp),%ebx\n\t"*/
