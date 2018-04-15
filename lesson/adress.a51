org 0000h
mov a, 30h
mov r0, #40h
mov r2, #5h
next: 
mov @r0, a
inc r0
inc a
djnz r2, next
mov a, #0
mov r2, #5
mov r1,0h
sum:
add a, @r1
dec r1
djnz r2, sum
end