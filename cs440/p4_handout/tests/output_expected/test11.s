.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp


.section .rodata
str0: .string "please enter a positive int <=12: "
.text
	movq $str0, %r10

.data
global_prompt: .long 0

.text
	movl %r10d, global_prompt(%rip)

	movl global_prompt(%rip), %r10d

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
L0:

	movl global_b(%rip), %r10d
	cmpl $0, %r10d
	je L1

	movl global_ans(%rip), %r10d

	movl global_i(%rip), %r11d
	imull %r11d, %r10d
	movl %r10d, global_ans(%rip)

	movl global_i(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
	movl %r10d, global_i(%rip)

	movl global_i(%rip), %r10d

	movl global_n(%rip), %r11d
	cmpl %r11d, %r10d
	setle %r10b
	movzbl %r10b, %r10d
	movl %r10d, global_b(%rip)
jmp L0
L1:

	movl global_ans(%rip), %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	popq %rbp
	ret
