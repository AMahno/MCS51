	org 0
	
	mov a, #1
	mov r0, #0
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
	mov dptr, #0A000h
	movx @dptr, a
	
	mov a, r1
		
	jmp wait
	
	end