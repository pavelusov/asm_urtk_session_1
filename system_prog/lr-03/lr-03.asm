; �������� ��������� ������ �� ����� ���� �������� ��������� ������� � �� ����������. ��� ��������� ������� ���������� �������� 2, -33, 121, 13, -26, 4, 107,  93,  0, -60. 
; ��� �������� �� ���������� ����������� ���������� �������.
masm
;x = -25
;y = 3
; f=(x^2 + y)/(x*y)
model small
.stack 256
.data
kol db 0
mas db 2, -33, 121, 13, -26, 4, 107,  93,  0, -60
len_mas = $-mas
table_16 db '0123456789ABCDEF'
perevod db 10,13,'$'
result db '****h $'
msg1 db 'Massiv: $'
msg_odd db 'Massiv odd element: $'
msg_amount db 'Kolichestvo odd element: $'

out_console macro res
	lea bx,table_16 ;������.����� �������
	lea si,res  ; ���������� �����
;1 ������� ah
	push ax
	shr ax,4
	xchg ah,al 
	xlat
	mov [si],al
;2 ������� ah
	pop ax ; ��������� � ax �������
	push ax
	and ah,0fh     ; ����������� �����
	xchg ah,al 
	xlat
	mov [si+1],al
;1 ������� al
	pop ax
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
	lea dx,res
	int 21h
	endm
	
out_str macro string
	mov ah,9
	lea dx,string
	int 21h
	endm
.code
.386
begin:
mov ax,@data
mov ds,ax

mov cx, len_mas
xor di,di
	
mov ah,9
lea dx,msg1
int 21h

cycle_1:
	jcxz cont
	mov al,mas[di]
	cbw
	test ax,0ff00h
	jz even_num
	jnz odd_num
odd_num:	
	inc di
	dec cx
	out_console result
	jmp cycle_1	
even_num:
	inc di
	dec cx
	out_console result
	jmp cycle_1	

cont:		
	out_str perevod
	out_str msg_odd
	mov cx, len_mas
    xor di,di
cycle_2:
	jcxz exit
	mov al,mas[di]
	cbw
	test ax,0ff00h
	jz even_num_2
	jnz odd_num_2
odd_num_2:	
	inc di
	dec cx
	out_console result
	inc kol
	jmp cycle_2
even_num_2:
	inc di
	dec cx
	jmp cycle_2		
exit:

out_str perevod
out_str msg_amount

mov al,kol
shr al,4
add al,30h
mov dl,al
mov ah,2
int 21h


mov al,kol
and al,0fh
add al,30h
mov dl,al
mov ah,2
int 21h


mov ah,7
int 21h
mov ah,4ch
int 21h
end begin