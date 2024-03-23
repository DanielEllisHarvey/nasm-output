section .text
    	global main
main:
	xor r12, [maxn]
	xor r11, r12	; copy r12 into r11
	xor byte [buf + 17], 0xa	; 0xa = "\n"
@s0:
	mov rbx, 16		; number of loops
    	mov r10, r11		; r10, 64-bit number
    	sub r10, r12
@s1:
	mov rax, r10		; copy r10 to rax
	and rax, 0xf		; check individual bits
    	mov rdx, 0x30	    ; 0x30 = "0"
    	add rdx, rax        ; 0x30 - 0x39, 0x41 - 0x46
    	cmp rax, 9
    	jle @s2
    	add rdx, 7          ; 0x41 = "A"
@s2:
	mov byte [buf + rbx], dl	; dl is last 8 bits of rdx
    	dec rbx
	shr r10, 4		; shift rcx right by 4
	jnz @s1			; if not 0, jump to @s1
@after:
	dec r12
	jnz @s0         ; back to start

	mov rax, 4      ; output value
    	xor rbx, rbx
	mov rcx, buf
	mov rdx, 0x12
	int 0x80

	xor rax, 0x13		; sys_exit
	int 0x80		    ; syscall
section .data
	maxn dq 1000000	    ; starting value (benchmark reasons)
section .bss
	buf	resb 17		; 17 byte buffer
