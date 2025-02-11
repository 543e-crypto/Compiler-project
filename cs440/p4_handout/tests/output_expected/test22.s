foo:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp


.section .rodata
str0: .string "foo\n"
.text
	movq $str0, %r10
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	movq 72(%rsp), %rdi
	movq 80(%rsp), %rsi
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movq 136(%rsp), %rax
foo_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret
bar:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp


.section .rodata
str1: .string "bar\n"
.text
	movq $str1, %r10
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)

	movq $LPRINT1, %rdi
	movq %r10, %rsi
	xorl %eax, %eax
	call printf
	movq 72(%rsp), %rdi
	movq 80(%rsp), %rsi
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movq 136(%rsp), %rax
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	call foo
	movq 72(%rsp), %rdi
	movq 80(%rsp), %rsi
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r10d
	movq 136(%rsp), %rax
bar_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret
.section .rodata #read-only data segment
LPRINT0: .string "%d\n" #format string for printint
LPRINT1: .string "%s\n" #format string for printstring
LGETINT: .string "%d" #format string for scanf to get an integer

.text
.globl main
main:
	push %rbp
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	call bar
	movq 72(%rsp), %rdi
	movq 80(%rsp), %rsi
	movq 88(%rsp), %rdx
	movq 96(%rsp), %rcx
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movl %eax, %r10d
	movq 136(%rsp), %rax

	popq %rbp
	ret
