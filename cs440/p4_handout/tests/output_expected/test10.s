.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movl $1, %r10d

.data
global_x: .long 0

.text
	movl %r10d, global_x(%rip)
L0:

	movl global_x(%rip), %r10d
	movl $3, %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L1

	movl global_x(%rip), %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	movl global_x(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
	movl %r10d, global_x(%rip)
jmp L0
L1:

	movl global_x(%rip), %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	popq %rbp
	ret
