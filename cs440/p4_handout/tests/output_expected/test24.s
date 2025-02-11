max:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp

.data
	max_x: .long 0
.text
	 movl %edi, max_x(%rip)

.data
	max_y: .long 0
.text
	 movl %esi, max_y(%rip)

.data
	max_z: .long 0
.text
	 movl %edx, max_z(%rip)

	movl max_x(%rip), %r10d

	movl max_y(%rip), %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L0

	movl max_x(%rip), %r10d

	movl max_z(%rip), %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L1

	movl max_x(%rip), %r10d

.data
max_m: .long 0

.text
	movl %r10d, max_m(%rip)
jmp L2
L1:

	movl max_z(%rip), %r10d
	movl %r10d, max_m(%rip)
L2:
jmp L3
L0:

	movl max_y(%rip), %r10d

	movl max_z(%rip), %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L4

	movl max_y(%rip), %r10d
	movl %r10d, max_m(%rip)
jmp L5
L4:

	movl max_z(%rip), %r10d
	movl %r10d, max_m(%rip)
L5:
L3:

	movl max_m(%rip), %r10d
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movq 72(%rsp), %rdi
	movq 80(%rsp), %rsi
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movq 136(%rsp), %rax
max_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret
.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $1, %r10d
	movl %r10d, %edi
	movl $2, %r10d
	movl %r10d, %esi
	movl $3, %r10d
	movl %r10d, %edx
	call max
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
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $3, %r10d
	movl %r10d, %edi
	movl $2, %r10d
	movl %r10d, %esi
	movl $1, %r10d
	movl %r10d, %edx
	call max
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
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $1, %r10d
	movl %r10d, %edi
	movl $3, %r10d
	movl %r10d, %esi
	movl $2, %r10d
	movl %r10d, %edx
	call max
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

	popq %rbp
	ret
