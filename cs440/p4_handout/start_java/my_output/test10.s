
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	movl $1, %r10d
.data
	global_x: .long 0
.text
	movl %r10d, global_x(%rip)
while1:
	movl global_x(%rip), %r10d
	movl $3, %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je while1_exit
	movl global_x(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
.text
	movl %r10d, global_x(%rip)
	jmp while1
while1_exit:
	movl global_x(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
