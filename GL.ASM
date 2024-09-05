title

.model small
.stack 100h
.data
columna db ?
linea db ?

keyboardArea label byte
 maxkeys db 6
 charsInput db ?
 buffer db 32 dup(0)

.code
main proc
  mov ax, @data
  mov ds, ax
 
  mov columna, 0
  mov linea, 0
  
  
  superior:
    mov al, " "
    cmp dl, 79
    je marco1
    mov dl, columna
    mov dh, linea
    call cursor
    call imprime
   ; call retardo
    inc columna
    jmp superior
 
 marco1:
 izquierdo:
   mov al, " "
   cmp dh, 25
   je marco2
   mov dl, columna
   mov dh, linea
   call cursor
   call imprime
   inc linea
   jmp izquierdo
   
   marco2:
   mov columna, 79
   mov linea, 0
   derecho:
   mov al, " "
   mov dl, columna
   mov dh, linea
   cmp dh, 25
   je marco3
   call cursor
   call imprime
   inc linea
   jmp derecho
   
   marco3:
   mov columna,0
   mov linea, 24
   abajo:
   mov al, " "
   mov dl, columna
   mov dh, linea
   cmp dl, 79
   je camino1
   call cursor
   call imprime
   inc columna
   jmp abajo
   
   camino:
   mov linea, 1
   mov columna , 3
   mov al, " "
   paso1:
     mov dl, columna
     mov dh, linea
     cmp dh, 12
     je paso2
     call cursor
     call camino
     call retardo
     inc linea
     jmp paso1
   
   
   paso2:
   mov dl, columna
   cmp dl, 39
   je paso3
   call cursor
   call camino
   call retardo
   inc columna
   jmp paso2
   
   paso3:
   mov dh, linea
   cmp dh, 22
   je msj
   call cursor
   call camino
   call retardo
   inc linea
   jmp paso3
   
   
   msj:
   mov ah, 0Ah
   mov dx, offset keyboardArea
   int 21h
   
   mov bx, offset keyboardArea
   mov si, 2
   mov cx, 0
   mov cl, [bx+1]
   
   
   ciclo:
      
mov ah, 4ch
int 21h
main endp

imprime proc
  push ax
  push bx
  push cx
  mov bh, 0
  mov bl, 2Fh
  mov cx, 1
  mov ah , 9
  int 10h
  pop cx
  pop bx
  pop ax
  ret
imprime endp

camino proc
  push ax
  push bx
  push cx
  mov bh,0
  mov bl,11h
  mov cx,1
  mov ah, 9
  int 10h
  pop cx
  pop bx
  pop ax
  ret
camino endp
 
cursor proc
  push ax
  push bx
  push dx
  mov ah, 2h
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