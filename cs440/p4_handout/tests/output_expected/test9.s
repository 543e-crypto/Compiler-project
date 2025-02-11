.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp


.section .rodata
str0: .string "Input a number:"
.text
	movq $str0, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf

.data
global_x: .long 0

.text
	movq $LGETINT, %rdi
	movq $global_x, %rsi
	xorl %eax, %eax
	call scanf

	movl global_x(%rip), %r10d
	movl $10, %r11d
	cmpl %r11d, %r10d
	setge %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L0


.section .rodata
str1: .string ">=10"
.text
	movq $str1, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
jmp L1
L0:


.section .rodata
str2: .string "<10"
.text
	movq $str2, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
L1:

	popq %rbp
	ret
