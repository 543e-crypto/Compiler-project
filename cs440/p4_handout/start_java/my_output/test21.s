return_it:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp
	movl $440, %r10d
	movl %r10d, %eax
	jmp return_it_exit
return_it_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret

.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	call return_it
	movq 72(%rsp), %rdi 
	movq 80(%rsp), %rsi 
	movq 88(%rsp), %rdx 
	movq 96(%rsp), %rcx 
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r10d
	movq 136(%rsp), %rax

.text
	movl %r10d, %edi
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
