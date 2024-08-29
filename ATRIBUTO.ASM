title

.model small
.stack 100h
.data
nombre db "Gustavoz", "$"
columna db ?

.code
main proc
  mov ax, @data
  mov ds, ax
 
  mov bx, offset nombre
  mov si, 0
  mov columna, 30
 
  ciclo:
    mov al, [bx+si]
    cmp al, "$"
    je fin
    mov dl, columna
    call cursor
    call imprime
    call retardo
    inc si
    inc columna
    jmp ciclo

fin:
mov ah, 4ch
int 21h
main endp

imprime proc
  push ax
  push bx
  push cx
  mov bh, 0
  mov bl, 1Eh
  mov cx, 1
  mov ah , 9
  int 10h
  pop cx
  pop bx
  pop ax
  ret
imprime endp

cursor proc
  push ax
  push bx
  push dx
  mov ah, 2h
  mov dh, 12
  mov bh, 0
  int 10h
  pop dx
  pop bx
  pop ax
  ret
cursor endp

retardo proc
  push bx
  mov bx, 0ffffh
  inicio:
    dec bx
    cmp bx, 0000
    jnz inicio
  pop bx
  ret
retardo endp

end