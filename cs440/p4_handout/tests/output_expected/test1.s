.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movl $5, %r10d
	movl $8, %r11d
	imull %r11d, %r10d
	movl $3, %r11d
	movl $2, %r12d
	negl %r12d
	imull %r12d, %r11d
	subl %r11d, %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	popq %rbp
	ret
