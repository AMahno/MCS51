	mov a, #1
	mov dptr, #256h
	
	mov TMOD, #01100001b
	mov TH0, #HIGH (1000-1)
	mov TL0, #LOW (1000-1)
	
	setb TR0
	
	wait: jnb TF0, wait
	rl a
	movx @dptr, a
	jmp wait
	
	end