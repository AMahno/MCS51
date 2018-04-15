	org 0000h
	
	wait: jnb p0.0, wait	
	
	mov r0, #20h //source data
	mov dptr, #256h //sink in the external memory
	
	loop_start:	
	mov a, @r0
		
	mov r1, #4 //loop counter
	mov r2, #1 //mask
	mov r3, a //"A" saving place
	mov r4, #0 //"1"s counter
	
	cmp_loop_1:
	anl a, r2 //apply mask
	jz zero_1
	inc r4 //1 is present, increment counter
	zero_1:
	mov a, r2 //rotate r2 (mask)
	rl a
	mov r2, a
	mov a, r3 //restore a
	djnz r1, cmp_loop_1
	
	
	swap a //work with other half-byte
	
	mov r1, #4 //loop counter
	mov r2, #1 //mask
	mov r3, a //"A" saving place
	mov r5, #0 //"1"s counter
		
	cmp_loop_2:
	anl a, r2
	jz zero_2
	inc r5
	zero_2:
	mov a, r2
	rl a
	mov r2, a
	mov a, r3 //restore a
	djnz r1, cmp_loop_2
	
	mov a, r5 //compare results
	xrl a, r4
	jz end_mark
	mov a, r3
	swap a
	
	anl a, #00Fh //sum up the half bytes and write to external memory
	mov r1, a
	mov a, @r0
	anl a, #0F0h
	swap a
	add a, r1
		
	movx @dptr, a
	inc r0
	inc dptr
	
	jmp loop_start
	
	end_mark:
	end