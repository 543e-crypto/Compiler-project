max:
	pushq %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $144, %rsp
.data
	max_x: .long 0
.text
	movl %edi, max_x(%rip)
.data
	max_y: .long 0
.text
	movl %esi, max_y(%rip)
.data
	max_z: .long 0
.text
	movl %edx, max_z(%rip)
if1:
	movl max_x(%rip), %r10d
	movl max_y(%rip), %r11d
	cmpl %r11d, %r10d
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else1
if2:
	movl max_x(%rip), %r10d
	movl max_z(%rip), %r11d
	cmpl %r11d, %r10d
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else2
	movl max_x(%rip), %r10d
.data
	max_m: .long 0
.text
	movl %r10d, max_m(%rip)
	jmp end_if2
else2:
	movl max_z(%rip), %r10d
.text
	movl %r10d, max_m(%rip)
	jmp end_if2
end_if2:
	jmp end_if1
else1:
if3:
	movl max_y(%rip), %r10d
	movl max_z(%rip), %r11d
	cmpl %r11d, %r10d
	setg %al
	movzbl %al, %eax
	cmpl $0, %eax
	je else3
	movl max_y(%rip), %r10d
.text
	movl %r10d, max_m(%rip)
	jmp end_if3
else3:
	movl max_z(%rip), %r10d
.text
	movl %r10d, max_m(%rip)
	jmp end_if3
end_if3:
	jmp end_if1
end_if1:
	movl max_m(%rip), %r10d
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movq $LPRINT0, %rdi
	movl %r10d, %esi
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

	jmp max_exit
max_exit:
	addq $144, %rsp
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	popq %rbp
	ret

.section .rodata
LPRINT0:  .string "%d\n"
LPRINT1:  .string "%s\n"
LGETINT:  .string "%d"
.text
.globl main
main:
	pushq %rbp
	movq %rdi, 72(%rsp)
	movq %rsi, 80(%rsp)
	movq %rdx, 88(%rsp)
	movq %rcx, 96(%rsp)
	movq %r8, 104(%rsp)
	movq %r9, 112(%rsp)
	movq %r10, 120(%rsp)
	movq %r11, 128(%rsp)
	movq %rax, 136(%rsp)
	movl $1, %r10d
.text
	movl %r10d, %edi
	movl $2, %r11d
.text
	movl %r11d, %esi
	movl $3, %r12d
.text
	movl %r12d, %edx
	call max
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
	movl $3, %r10d
.text
	movl %r10d, %edi
	movl $2, %r11d
.text
	movl %r11d, %esi
	movl $1, %r12d
.text
	movl %r12d, %edx
	call max
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
	movl $1, %r10d
.text
	movl %r10d, %edi
	movl $3, %r11d
.text
	movl %r11d, %esi
	movl $2, %r12d
.text
	movl %r12d, %edx
	call max
	movq 72(%rsp), %rdi 
	movq 80(%rsp), %rsi 
	movq 88(%rsp), %rdx 
	movq 96(%rsp), %rcx 
	movq 104(%rsp), %r8
	movq 112(%rsp), %r9
	movq 120(%rsp), %r10
	movq 128(%rsp), %r11
	movq 136(%rsp), %rax

.text
	popq %rbp
	ret
