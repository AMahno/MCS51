	org 0
	
	mov a, #1
	mov r0, #0
	mov r2, #0
	mov r3, #0
	mov TMOD, #01100001b
	setb TR0
		
	wait: jnb TF0, wait
	clr TF0
	
	rl a
	mov dptr, #0A006h
	movx @dptr, a
	
	mov r1, a
	
	cjne r0, #8, not_equals
	mov r0, #0
	not_equals:
	inc r0
		
	mov a, r0	

	cjne r2, #0Fh, not_eq_swap
	mov r3, #0
	not_eq_swap:
		
	cjne r2, #1Eh, not_eq_swap2
	mov r3, #1
	mov r2, #0
	not_eq_swap2:
	
	cjne r3, #1, swapping
	swap a
	swapping:
	
	inc r2
	
	mov dptr, #0A000h
	movx @dptr, a
	
	swap a
	mov dptr, #0B000h
	movx @dptr, a
	swap a
	
	mov a, r1
		
	jmp wait
	
	end