	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w"
	.align 8
.LC1:
	.string	"you must provide 3 valid file paths"
	.text
	.globl	printUnique
	.type	printUnique, @function
printUnique:
	push	rbp
	mov	rbp, rsp
	push	r13
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	rax, QWORD PTR -48[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -24[rbp], 0
	jne	.L2
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L1
.L2:
	mov	r13d, 0
	jmp	.L4
.L6:
	mov	eax, r13d
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 2
	jne	.L5
	mov	edx, r13d
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	mov	edi, edx
	call	fputc@PLT
.L5:
	mov	eax, r13d
	add	eax, 1
	mov	r13d, eax
.L4:
	mov	eax, r13d
	cmp	eax, 127
	jle	.L6
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fclose@PLT
.L1:
	mov	r13, QWORD PTR -8[rbp]
	leave
	ret
	.size	printUnique, .-printUnique