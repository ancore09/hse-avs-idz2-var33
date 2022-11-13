	.file	"33.c"
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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r13
	sub	rsp, 40
	.cfi_offset 13, -24
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
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	printUnique, .-printUnique
	.section	.rodata
.LC2:
	.string	"r"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r14
	push	r13
	push	r12
	sub	rsp, 40
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 4
	je	.L8
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L9
.L8:
	mov	edi, 128
	call	malloc@PLT
	mov	r14, rax
	mov	r13d, 0
	jmp	.L10
.L11:
	mov	rdx, r14
	mov	eax, r13d
	cdqe
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	eax, r13d
	add	eax, 1
	mov	r13d, eax
.L10:
	mov	eax, r13d
	cmp	eax, 127
	jle	.L11
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax
	cmp	QWORD PTR -48[rbp], 0
	jne	.L13
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L9
.L14:
	mov	rdx, r14
	mov	eax, r12d
	movsx	rax, al
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L13
	mov	rdx, r14
	mov	eax, r12d
	movsx	rax, al
	add	rax, rdx
	mov	BYTE PTR [rax], 1
.L13:
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	r12d, eax
	mov	eax, r12d
	cmp	al, -1
	jne	.L14
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	QWORD PTR -40[rbp], 0
	jne	.L16
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L9
.L17:
	mov	rdx, r14
	mov	eax, r12d
	movsx	rax, al
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 1
	jne	.L16
	mov	rdx, r14
	mov	eax, r12d
	movsx	rax, al
	add	rax, rdx
	mov	BYTE PTR [rax], 2
.L16:
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	r12d, eax
	mov	eax, r12d
	cmp	al, -1
	jne	.L17
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdx, r14
	mov	rsi, rax
	mov	rdi, rdx
	call	printUnique
	mov	rax, r14
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L9:
	add	rsp, 40
	pop	r12
	pop	r13
	pop	r14
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
