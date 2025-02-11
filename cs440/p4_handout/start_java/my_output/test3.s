
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
.data
	global_x: .long 0
.text
	movq $LGETINT, %rdi
	movq $global_x, %rsi
	xorl %eax, %eax
	call scanf
	movl $1, %r10d
	movl global_x(%rip), %r11d
	movl $2, %r12d
	imull %r12d, %r11d
	subl %r11d, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
