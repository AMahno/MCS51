org 0h
mov a, #0
mov dptr, #0A000h
movx @dptr, a
mov TMOD, #20h
mov TH1, #-6h
mov SCON, #50h
setb TR1
/*
here: jnb RI, here
mov a, SBUF
mov r1, a
xrl a, #0FFh
jz nodata
mov a, r1
mov dptr, #0A000h
movx @dptr, a
nodata:
clr RI
sjmp here
*/
again: mov SBUF, #"A"
here: jnb TI, here
clr TI
sjmp again
end