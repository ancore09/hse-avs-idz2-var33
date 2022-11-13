	.file	"33no-regs.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w"
	.text
	.globl	printUnique
	.type	printUnique, @function
printUnique:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -12[rbp], 0
	jmp	.L2
.L4:
	mov	eax, DWORD PTR -12[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 2
	jne	.L3
	mov	rdx, QWORD PTR -8[rbp]
	mov	eax, DWORD PTR -12[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
.L3:
	add	DWORD PTR -12[rbp], 1
.L2:
	cmp	DWORD PTR -12[rbp], 127
	jle	.L4
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	nop
	leave
	ret
	.size	printUnique, .-printUnique
	.section	.rodata
.LC1:
	.string	"r"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	edi, 128
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -28[rbp], 0
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -28[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	add	DWORD PTR -28[rbp], 1
.L6:
	cmp	DWORD PTR -28[rbp], 127
	jle	.L7
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L8
.L9:
	movsx	rdx, BYTE PTR -29[rbp]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L8
	movsx	rdx, BYTE PTR -29[rbp]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 1
.L8:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -29[rbp], al
	cmp	BYTE PTR -29[rbp], -1
	jne	.L9
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	jmp	.L10
.L11:
	movsx	rdx, BYTE PTR -29[rbp]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 1
	jne	.L10
	movsx	rdx, BYTE PTR -29[rbp]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 2
.L10:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -29[rbp], al
	cmp	BYTE PTR -29[rbp], -1
	jne	.L11
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 24
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	printUnique
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
