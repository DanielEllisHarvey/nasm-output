section .text
	global main

main:
	mov r12, [maxn]
	mov rbx, 1		; always stdout
	mov rdx, 1		; always byte
@a:
	mov r8, 64			; r8, number of loops
	mov r9, 1 << 63		; r9, bit mask
	mov r10, r12		; r10, 64-bit number

@s1:
	mov r11, 0x30
	mov rax, r10	; copy r10 to rax
	and rax, r9		; check individual bit
	jz @0
	inc r11
@0:
	mov qword [buf], r11

	mov rax, 4
	mov rcx, buf
	int 0x80

	shr r9, 1	; shift r9 right by 1
	dec r8		; decrement r8
	jnz @s1		; if not 0, jump to @s1

	mov byte [buf], 0xa
	mov rax, 4		; sys_write
	mov rcx, buf	; endl
	int 0x80		; syscall

@after:
	dec r12
	jnz @a

	mov rax, 1		; sys_exit
	xor rbx, rbx	; status 0
	int 0x80		; syscall

section .data
	maxn dd 19000
section .bss
	buf	resb 1
