.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movl $1, %r10d
	movl $1, %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L0


.section .rodata
str0: .string "yes"
.text
	movq $str0, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
L0:
	movl $1, %r10d
	movl $2, %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d
	cmpl $0, %r10d
	je L1


.section .rodata
str1: .string "no"
.text
	movq $str1, %r10

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
L1:

	popq %rbp
	ret
