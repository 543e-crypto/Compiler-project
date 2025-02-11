
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
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
.text
	popq %rbp
	ret
