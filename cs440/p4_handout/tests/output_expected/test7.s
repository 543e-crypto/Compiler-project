.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movl $1, %r10d
	movl $2, %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl $1, %r10d
	movl $2, %r11d
	cmpl %r11d, %r10d
	setne %r10b
	movzbl %r10b, %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	popq %rbp
	ret
