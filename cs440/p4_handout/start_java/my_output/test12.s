
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
	movl $10, %r11d
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
	movl $2, %r11d
	movl %r10d, %eax
	cdq
	movl %r11d, %ebx
	idivl %ebx
	movl %eax, %r11d
.data
	global_y: .long 0
.text
	movl %r11d, global_y(%rip)
if1:
	movl global_y(%rip), %r10d
	movl $2, %r11d
	imull %r11d, %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	sete %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else1
	.section .rodata
	str1:	.string ":even"
	.text
	movq $str1, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	jmp end_if1
else1:
	.section .rodata
	str2:	.string ":odd"
	.text
	movq $str2, %r10
	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	jmp end_if1
end_if1:
	movl global_x(%rip), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
.text
	movl %r10d, global_x(%rip)
	jmp while1
while1_exit:
.text
	popq %rbp
	ret
