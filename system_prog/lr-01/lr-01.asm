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

mov dx,7890h          ; ��������� � dx 7890h 
mov bl,56h            ; � ������� ���� bx �������� 56h
mov cl,dh             ; ����������� ������� ���� DX � �������? ���� ��
mov ax,word ptr ASD+2 ; ������� ����� ���������� ASD ����������� � AX,
mov bp,word ptr ASD   ; ������� ����� ���������� ASD ����������� � BP.	
mov di,a              ; ���������� � ������ -600 ����������� � DI
push cx               ; ��������� ���� ����������� 
pop di                ; ����� ����������� �� � DI
xchg ch,dl            ; ��������� ����� ����������� �������� ����� DX � �������� ����� �X.

mov ah,4ch
int 21h
end begin