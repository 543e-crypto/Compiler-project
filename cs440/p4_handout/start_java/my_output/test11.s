
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	.section .rodata
	str1:	.string "please enter a positive int <=12: "
	.text
	movq $str1, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
.data
	global_n: .long 0
.text
	movq $LGETINT, %rdi
	movq $global_n, %rsi
	xorl %eax, %eax
	call scanf
	movl $1, %r10d
.data
	global_i: .long 0
.text
	movl %r10d, global_i(%rip)
	movl $1, %r10d
.data
	global_ans: .long 0
.text
	movl %r10d, global_ans(%rip)
	movl global_i(%rip), %r10d
	movl global_n(%rip), %r11d
	cmpl %r11d, %r10d
	setle %r10b
	movzbl %r10b, %r10d
.data
	global_b: .long 0
.text
	movl %r10d, global_b(%rip)
while1:
	movl global_b(%rip), %r10d
	cmpl $0, %r10d
	je while1_exit
	movl global_ans(%rip), %r10d
	movl global_i(%rip), %r11d
	imull %r11d, %r10d
.text
	movl %r10d, global_ans(%rip)
	movl global_i(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
.text
	movl %r10d, global_i(%rip)
	movl global_i(%rip), %r10d
	movl global_n(%rip), %r11d
	cmpl %r11d, %r10d
	setle %r10b
	movzbl %r10b, %r10d
.text
	movl %r10d, global_b(%rip)
	jmp while1
while1_exit:
	movl global_ans(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
