section .text
	global main
main:
	xor r12, [maxn]
	xor byte [buf + 0x41], 0xa	; 0xa = "\n"
@s0:
	mov rbx, 64			; number of loops
	mov r10, r12		; r10, 64-bit number being converted
	mov rdx, 0x30
@s1:
	mov rax, r10		; rax, single bit value
	and rdx, 0x30		; 0x30 = "0"
	and rax, 0x1		; check individual bit
	or rdx, rax			; 0x31 = "1"
	mov byte [buf + rbx], dl	; dl is last 8 bits of rdx
	dec rbx				; move value index
	shr r10, 1			; shift by 1 to next value
	jnz @s1
	cmp byte [buf + rbx], 0x0
	je @s4
@s3:
	mov byte [buf + rbx], 0x0	; replace unused bytes with 0x0
	dec rbx
	jnz @s3
@s4:
	dec r12
	jnz @s0				; back to start
	mov rax, 4			; output value
	mov rbx, 0
	mov rcx, buf
	mov rdx, 0x42
	int 0x80

	xor rax, 0x43		; sys_exit
	int 0x80
section .data
	maxn dq 1000000		; starting value (benchmark reasons)
section .bss
	buf	resb 65			; 65 byte buffer
