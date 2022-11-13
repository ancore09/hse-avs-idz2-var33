# Отчет по ИДЗ №2

### Код на C
```c
#include "stdio.h"
#include "stdlib.h"

void printUnique(char *arr, char *path)
{
    FILE *fp = fopen(path, "w");
    if (fp == NULL) {
        printf("you must provide 3 valid file paths\n");
        return;
    }

    register int i asm("r13");
    // print all true values
    for (i = 0; i < 128; i++) {
        if (arr[i] == 2) {
            fprintf(fp, "%c", i);
        }
    }
    fclose(fp);
}

int main(int argc, char *argv[]) {

    if (argc != 4) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }

    register int i asm("r13");
    register char *a asm("r14") = (char *)malloc(128 * sizeof(char));
    register char c asm("r12");
    // initialize all values to 0
    for (i = 0; i < 128; i++) {
        a[i] = 0;
    }

    // read string from file
    FILE *fp1 = fopen(argv[1], "r");
    if (fp1 == NULL) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }
    while ((c = fgetc(fp1)) != EOF) {
        if (a[c] == 0) {
            a[c] = 1;
        }
    }
    fclose(fp1);

    FILE *fp2 = fopen(argv[2], "r");
    if (fp2 == NULL) {
        printf("you must provide 3 valid file paths\n");
        return 1;
    }
    while ((c = fgetc(fp2)) != EOF) {
        if (a[c] == 1) {
            a[c] = 2;
        }
    }
    fclose(fp2);

    printUnique(a, argv[3]);
    free(a);
    
    return 0;
}
```

### Компиляция программы без оптимизаций
```sh
gcc -masm=intel -S 33.c -o 33.s
```

### Компиляция программы с оптимизацией
```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 33.c -o 33c.s
```

### Тестовые прогоны
```sh
./a.out *in_path1* *in_path2* *out_path*
```

| Входные данные  | 33.s            | 33c.s           |
|-----------------|:---------------:|:---------------:|
| *пустая строка* / *пустая строка* | *пустая строка* | *пустая строка* |
| bc / bac     | bc     | bc     |
| hello world! / hi walle    | _ehlw | _ehlw |

### Комментарии в asm коде
```assembly
    mov	rdx, r14
	mov	rsi, rax			# rsi = path
	mov	rdi, rdx			# rdi = arr
	call	printUnique		# printUnique(arr, path)
	mov	rax, r14
```

### Разбиение Asm кода на две единицы компиляции
#### 33_1.s
```assembly
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

```

#### 33_2.s
```assembly
	            .intel_syntax noprefix
	.text
    	.section	.rodata
.LC1:
	.string	"you must provide 3 valid file paths"
.LC2:
	.string	"r"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r13
	push	r12
	sub	rsp, 40
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
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits

```

#### Коплиляция программы из двух единиц компиляции
```bash
gcc 33_1.s 33_2.s -o part.out
```

### Сравнение размера программы на регистрах и на стеке

#### Размер программы на регистрах
204 строки
#### Размер программы на стеке
183 строки