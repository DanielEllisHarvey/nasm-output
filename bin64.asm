section .text
	global main
main:
	xor r12, [maxn]
	xor r11, r12		; copy r12 into r11
	xor byte [buf + 0x41], 0xa	; 0xa = "\n"
@s0:
	mov rbx, 64		; number of loops
	mov r10, r11		; r10, 64-bit number
	sub r10, r12
@s1:
	mov rdx, 0x30		; 0x30 = "0"
	mov rax, r10		; copy r10 to rax
	and rax, 1		; check individual bit
	xor rdx, rax		; 0x31 = "1"
	mov byte [buf + rbx], dl	; dl is last 8 bits of rdx
	dec rbx
	shr r10, 1		; shift r9 right by 1
	jnz @s1			; if not 0, jump to @s1
@after:
	dec r12
	jnz @s0			; back to start

	mov rax, 4
	mov rbx, 0
	mov rcx, buf
	mov rdx, 0x42
	int 0x80

	xor rax, 0x43		; sys_exit
	int 0x80		; syscall
section .data
	maxn dq 1000000		; starting value (benchmark reasons)
section .bss
	buf	resb 65		; 65 byte buffer
