.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
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
	movl %r11d, %ebx
	cdq
	idiv %ebx
	movl %eax, %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	popq %rbp
	ret
