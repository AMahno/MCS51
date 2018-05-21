	org 0h

loop:
	jnb p1.7, comp
	jmp no_comp
	comp:
	
	mov R4,#0ffh
	C2: mov R2,#0FFh
	C3: djnz R2, C3
	djnz R4, C2 
	
	mov DPTR, #0B000h
	movx @dptr, a
	mov a, #0h
		
	no_comp:
	inc a
	mov DPTR, #0F000h
	movx @DPTR, a
	
	mov R4,#0ffh
	c4: djnz R4, C4 
	
	jmp loop
	end