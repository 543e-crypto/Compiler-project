decrement:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp
.data
	decrement_x: .long 0
.text
	movl %edi, decrement_x(%rip)
	movl decrement_x(%rip), %r10d
	movl $1, %r11d
	subl %r11d, %r10d
	movl %r10d, %eax
	jmp decrement_exit
decrement_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret
increment:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp
.data
	increment_x: .long 0
.text
	movl %edi, increment_x(%rip)
	movl increment_x(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
	movl %r10d, %eax
	jmp increment_exit
increment_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret
compute:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp
.data
	compute_x: .long 0
.text
	movl %edi, compute_x(%rip)
.data
	compute_y: .long 0
.text
	movl %esi, compute_y(%rip)
	movl compute_y(%rip), %r10d
.data
	compute_sum: .long 0
.text
	movl %r10d, compute_sum(%rip)
while1:
	movl compute_x(%rip), %r10d
	movl $0, %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je while1_exit
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl compute_sum(%rip), %r10d
.text
	movl %r10d, %edi
	call increment
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
.text
	movl %r10d, compute_sum(%rip)
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl compute_x(%rip), %r10d
.text
	movl %r10d, %edi
	call decrement
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
	movl %r10d, %esi
.text
	movl %r10d, compute_x(%rip)
	jmp while1
while1_exit:
	movl compute_sum(%rip), %r10d
	movl %r10d, %eax
	jmp compute_exit
compute_exit:
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
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $25, %r10d
.text
	movl %r10d, %edi
	movl $25, %r11d
.text
	movl %r11d, %esi
	call compute
	movq 72(%rsp), %rdi 
	movq 80(%rsp), %rsi 
	movq 88(%rsp), %rdx 
	movq 96(%rsp), %rcx 
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r11d
	movq 136(%rsp), %rax

.text
	movl %r11d, %edx
.text
	movl %r11d, %edi
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $25, %r12d
.text
	movl %r12d, %edi
	movl $25, %r13d
.text
	movl %r13d, %esi
	call compute
	movq 72(%rsp), %rdi 
	movq 80(%rsp), %rsi 
	movq 88(%rsp), %rdx 
	movq 96(%rsp), %rcx 
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r13d
	movq 136(%rsp), %rax

.text
	movl %r13d, %ecx
.text
	movl %r13d, %edx
	call compute
	movq 72(%rsp), %rdi 
	movq 80(%rsp), %rsi 
	movq 88(%rsp), %rdx 
	movq 96(%rsp), %rcx 
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r13d
	movq 136(%rsp), %rax

.text
	movl %r13d, %r8d
	movq $LPRINT0, %rdi
	movl %r13d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
