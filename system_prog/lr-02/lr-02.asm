masm
;x = -25
;y = 3
; f=(x^2 + y)/(x*y)
model small
.stack 256
.data
x db -25 ; e7
y db 3   ; 03
c db 30  ; 1e
table_16 db '0123456789ABCDEF'
result db '****h',10,13,'$'
msg1 db 'Resultat v 16-m vide: $'
sum dw ?
mult dw ?
chastn dw ?
.code
.386
begin:
mov ax,@data
mov ds,ax


movsx ax,x ; ffe7h -25
imul ax     ; -25^2               1)x^2
movzx bx,y ; 0003h
add ax,bx  ; ax = 0274h - 628    2)(x^2+y)
mov sum,ax ; sum = 0274h

movsx ax,x ; ffe7h -25
mul bx     ; ax = ffb5h -75      3)x*y
mov mult,ax

mov ax,sum
cwd
mov bx,mult                  
idiv bx                      ; 4)(x^2 + y)/(x*y)

mov chastn,ax

mov ah,9
lea dx,msg1
int 21h


lea bx,table_16 ;������.����� �������
lea si,result  ; ���������� �����
;1 ������� ah
mov ax,chastn  ; ��������� � ax �������
push ax
shr ax,4
xchg ah,al 
xlat
mov [si],al
;2 ������� ah
pop ax ; ��������� � ax �������
and ah,0fh     ; ����������� �����
xchg ah,al 
xlat
mov [si+1],al
;1 ������� al
mov ax,chastn  ; ��������� � ax �������
push ax
shr al,4       ; �������� ������ �� 4 ����
xlat            ; ����� �������� �� ����� �������
mov [si+2],al     ; ������ �������� ������� ����� � si
;2 ������� al
pop ax  ; ��������� � ax �������
and al,0fh      ; ����������� �����
xlat            ; ����� �������� �� ����� �������
mov [si+3],al

;������� � �������
mov ah,9
lea dx,result
int 21h

mov ah,7
int 21h
mov ah,4ch
int 21h
end begin