
.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
if1:
	movl $1, %r10d
	movl $1, %r11d
	cmpl %r11d, %r10d
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else1
	.section .rodata
	str1:	.string "yes"
	.text
	movq $str1, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
else1:
	jmp end_if1
end_if1:
if2:
	movl $1, %r10d
	movl $2, %r11d
	cmpl %r11d, %r10d
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else2
	.section .rodata
	str2:	.string "no"
	.text
	movq $str2, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
else2:
	jmp end_if2
end_if2:
.text
	popq %rbp
	ret
