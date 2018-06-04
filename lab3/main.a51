	org 0h
	ljmp begin
	
	org 001Bh
	call isr
	reti
	
	org 30h
begin:
	clr ea
	clr tr1
	mov TMOD, #00010001b
	mov TCON, #01000001b
	setb ea
	setb et1
	setb tr1


poll_kb:
	mov dptr, #09006h ;first row
	movx a, @dptr
	mov r2, a
	call test
	jz row2
	call debounce
	call test
	jnz det_but_1
	
row2:
	mov dptr, #09005h
	movx a, @dptr
	mov r2, a
	call test
	jz row3
	call debounce
	call test
	jnz det_but_2
	
row3:
	mov dptr, #09003h
	movx a, @dptr
	mov r2, a
	call test
	jz poll_kb
	call debounce
	call test
	jnz det_but_3
	jmp poll_kb

det_but_1:
	mov a, r2

key1:
	cjne a, #0FEh, key4
	mov r7, #06h
	call out
	
key4:
	cjne a, #0FDh, key7
	mov r7, #66h
	call out
	
key7:
	cjne a, #0FBh, key_star
	mov r7, #07h
	call out

key_star:
	cjne a, #0F7h, row2
	mov r7, #71h
	call out
	jmp poll_kb

det_but_2:
	mov a, r2

key2:
	cjne a, #0FEh, key5
	mov r7, #5Bh
	call out
	
key5:
	cjne a, #0FDh, key8
	mov r7, #6Dh
	call out
	
key8:
	cjne a, #0FBh, key0
	mov r7, #7Fh
	call out

key0:
	cjne a, #0F7h, row2
	mov r7, #3Fh
	call out
	jmp poll_kb

det_but_3:
	mov a, r2

key3:
	cjne a, #0FEh, key6
	mov r7, #4Fh
	call out
	
key6:
	cjne a, #0FDh, key9
	mov r7, #7Dh
	call out
	
key9:
	cjne a, #0FBh, key_die
	mov r7, #6Fh
	call out

key_die:
	cjne a, #0F7h, proxy_row_2
	mov r7, #79h
	call out
	jmp poll_kb

out:
	mov r1, a
	mov a, r7
	mov dptr, #0A000h
	movx @dptr, a
	mov a, r1
	ret

debounce:
	mov TH0, #0A0h
	mov TL0, #00h
	setb TR0
wait:
	jnb TF0, wait
	clr TR0
	clr TF0
	ret
	
test:
	orl a, #0F0h
	cpl a
	ret
	
	jmp finish
	proxy_row_2:
	ljmp row2
	
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
	mov a, r7
	movx @dptr, a
	mov a, r5
	ret
	
	finish:	
end