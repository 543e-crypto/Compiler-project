
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	.section .rodata
	str1:	.string "Input a number:"
	.text
	movq $str1, %r10
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
if1:
	movl global_x(%rip), %r10d
	movl $10, %r11d
	cmpl %r11d, %r10d
	setge %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else1
	.section .rodata
	str2:	.string ">=10"
	.text
	movq $str2, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	jmp end_if1
else1:
	.section .rodata
	str3:	.string "<10"
	.text
	movq $str3, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	jmp end_if1
end_if1:
.text
	popq %rbp
	ret
