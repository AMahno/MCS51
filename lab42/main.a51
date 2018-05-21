	org 0h
	ljmp begin

	org 0003h
	call isr
	reti

	org 30h
	one: db 0Eh, 4h, 4h, 4h, 4h, 0Ch, 4h
	//org 37h
	two: db	1Eh, 10h, 8h, 4h, 2h, 12h, 0Ch
	//org 3eh
	three: db 0Eh, 1h, 1h, 6h, 2h, 1h, 0Eh
	//org 45h	
	four: db 2h, 2h, 2h, 1Fh, 0Ah, 4h, 2h
	//org 4Ch
	five: db 0Eh, 1h, 1h, 1h, 0Eh, 8h, 0Fh
	//org 53h
	six: db 0Ch, 12h, 12h, 1Ch, 10h, 10h, 0Eh
	//org 5Ah
	seven: db 8h, 8h, 1Ch, 8h, 4h, 2h, 1Eh
	//org 61h
	eight: db 0Eh, 11h, 11h, 0Eh, 11h, 11h, 0Eh
	//org 68h
	nine: db 1Eh, 1h, 1h, 0Fh, 11h, 11h, 0Eh
	zero: db 0Eh, 11h, 11h, 11h, 11h, 11h, 0Eh
	org 100h
begin:
	
	clr ea
	clr tr1
	mov TMOD, #00010001b
	mov TCON, #01000001b
	setb ea
	setb ex0
	//setb et1
	//setb tr1
	setb TR0

	mov r4, #0h

outer_loop:

	mov r0, #7
	mov r1, #1
	mov r2, #0
	
	loop:
	mov a, r4
	mov b, #7h
	mul ab
	add a, r2
	
	mov dptr, #0A000h
	movx @dptr, a
	
	mov dptr, #30h
	movc a, @a+dptr
	inc r2
	
	mov dptr, #8000h
	movx @dptr, a
	
	mov a, r1
	cpl a
	mov dptr, #8002h
	movx @dptr, a
	cpl a
	rl a
	mov r1, a

	mov TH0, #0FEh
	wait: jnb TF0, wait
	clr TF0

	djnz r0, loop
		
	jmp outer_loop
	
	
	isr:
	mov r7, a
	
	setb TR1
	debounce: jnb TF1, debounce
	
	mov a, r4
	xrl a, #9h
	jz equals
	jmp not_equals
	equals:
	mov r4, #-1h
	not_equals:
	inc r4
	
	
	mov a, r7
	ret
end