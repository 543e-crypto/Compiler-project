
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
	movl global_x(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl $5, %r10d
	movl $7, %r11d
	cmpl %r11d, %r10d
	setge %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl $5, %r10d
.text
	movl %r10d, global_x(%rip)
	movl $7, %r10d
.data
	global_y: .long 0
.text
	movl %r10d, global_y(%rip)
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	sete %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setne %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setne %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setne %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setle %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setle %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setg %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setge %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_y(%rip), %r10d
	movl global_x(%rip), %r11d
	cmpl %r11d, %r10d
	setge %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.data
	global_z: .long 0
.text
	movq $LGETINT, %rdi
	movq $global_z, %rsi
	xorl %eax, %eax
	call scanf
	movl global_z(%rip), %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	movq $LGETINT, %rdi
	movq $global_x, %rsi
	xorl %eax, %eax
	call scanf
.text
	movq $LGETINT, %rdi
	movq $global_y, %rsi
	xorl %eax, %eax
	call scanf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	addl %r11d, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
	movl global_x(%rip), %r10d
	movl global_y(%rip), %r11d
	cmpl %r11d, %r10d
	setl %r10b
	movzbl %r10b, %r10d
	movq $LPRINT0, %rdi
	movl %r10d, %esi
	xorl %eax, %eax
	call printf
.text
	popq %rbp
	ret
