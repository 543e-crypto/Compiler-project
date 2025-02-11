
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	movl $10, %r10d
.data
	global_x: .long 0
.text
	movl %r10d, global_x(%rip)
	movl $4, %r10d
.data
	global_y: .long 0
.text
	movl %r10d, global_y(%rip)
	movl global_y(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
.data
	global_z: .long 0
.text
	movl %r10d, global_z(%rip)
	movl global_z(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_z(%rip), %r11d
	movl %r10d, %eax
	cdq
	movl %r11d, %ebx
	idivl %ebx
	movl %eax, %r11d
	movq $LPRINT0, %rdi
	movl %r11d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
