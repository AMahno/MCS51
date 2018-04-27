	org 0h
	ljmp main
	
	org 000Bh
	call isr
	reti
	
	
	org 30h
	main:
	clr ea;
	clr tr0;
	mov TMOD, #01100001b
	;clr pt0;
	setb ea;
	setb et0;
	setb tr0;
	
	
	/*	
	mov dptr, #8002h
	mov a, #00h
	movx @dptr, a
	mov dptr, #8001h
	mov a, 0ffh
	movx @dptr, a
	*/
	loop:
	jmp loop
	
	isr:
	mov r5, a
	mov a, r6
	xrl a, #4h
	jnz not_equals
	mov r6, #0h
	not_equals:
	inc r6
	mov a, r6
	mov dptr, #8002h
	movx @dptr, a
	mov dptr, #8001h
	mov a, #0Fh
	movx @dptr, a
	mov a, r5
	ret
	end
	