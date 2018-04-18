; 4
masm
model small
.stack 256
.data
a dw -600
ASD dd 1233445
.code
begin:
mov ax,@data
mov ds,ax

mov dx,7890h          ; загрузить в dx 7890h 
mov bl,56h            ; в младший байт bx записать 56h
mov cl,dh             ; Скопировать старшии баит DX в младшии? баит СХ
mov ax,word ptr ASD+2 ; Старшее слово переменнои ASD скопировать в AX,
mov bp,word ptr ASD   ; младшее слово переменнои ASD скопировать в BP.	
mov di,a              ; Переменную с числом -600 скопировать в DI
push cx               ; Используя стек осуществить 
pop di                ; обмен содержимого СХ и DI
xchg ch,dl            ; Выполнить обмен содержимого младшего баита DX и старшего баита СX.

mov ah,4ch
int 21h
end begin