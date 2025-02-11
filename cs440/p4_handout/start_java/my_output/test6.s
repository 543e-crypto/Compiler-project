
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	.section .rodata
	str1:	.string "May the force be with you."
	.text
	movq $str1, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
