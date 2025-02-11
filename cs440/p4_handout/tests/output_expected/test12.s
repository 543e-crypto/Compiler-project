.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movl $1, %r10d

.data
global_x: .long 0

.text
	movl %r10d, global_x(%rip)
L0:

	movl global_x(%rip), %r10d
	movl $10, %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L1

	movl global_x(%rip), %r10d

	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf

	movl global_x(%rip), %r10d
	movl $2, %r11d
	movl %r10d, %eax
	movl %r11d, %ebx
	cdq
	idiv %ebx
	movl %eax, %r10d

.data
global_y: .long 0

.text
	movl %r10d, global_y(%rip)

	movl global_y(%rip), %r10d
	movl $2, %r11d
	imull %r11d, %r10d

	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L2


.section .rodata
str0: .string ":even"
.text
	movq $str0, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
jmp L3
L2:


.section .rodata
str1: .string ":odd"
.text
	movq $str1, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
L3:

	movl global_x(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
	movl %r10d, global_x(%rip)
jmp L0
L1:

	popq %rbp
	ret
