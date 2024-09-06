title

.model small
.stack 100h
.data
msj1 db "Escribe una palabra de 3 - 6 letras: ", "$"
aux1 db ?
aux2 db ?


keyboardArea label byte
  maxkeys db 6
  charsInput db ?
  buffer db 32 dup("$")

.code
main proc
  mov ax, @data
  mov ds, ax
  
  ;marco suerior
  mov dl, 0
  mov dh, 0
  mov al, " "
  call m_horizontal
  
  mov dl, 0
  mov dh, 1
  call m_horizontal
  
  ;marco izquierdo
  mov dl, 0
  mov dh, 0
  call m_vertical
  
  mov dl, 1
  mov dh, 0
  call m_vertical
  
  ;marco derecho
  mov dl, 79
  mov dh, 0
  call m_vertical
  
  mov dl, 78
  mov dh, 0
  call m_vertical
  
  ; marco inferior
  mov dl, 0
  mov dh, 24
  call m_horizontal
  
  mov dl, 0
  mov dh, 23
  call m_horizontal
  
  ;Dibujar Camino
  mov dl, 3
  mov dh, 1
  call camino1
  mov dl, 3
  mov dh, 12
  call camino2
  mov dl, 39
  mov dh, 12
  call camino3
      
  ;imprime mensaje
  ;Peticion
  mov dh, 4
  mov dl, 4
  call cursor
  
  mov dx, offset msj1
  mov ah, 9h
  int 21h

  ;lectura
  mov ah, 0Ah
  mov dx, offset keyboardArea
  int 21h
  
  ;Camino Letra
  mov bx, offset keyboardArea
  mov si, 2
  mov cx, 0
  mov cl, [bx+1]
  
  mov aux1, 23
  mov aux2, 37
  ciclo:
    mov al, [bx+si]
    mov dl, 3
    mov dh, 1
    call camino1_L
    mov dl, 3
    mov dh, 12
    call camino2_L
    mov dl, 39
    mov dh, 12
    call camino3_L
    
    mov dh, aux1
    mov dl, aux2
    call cursor
    call d_camino_L
    inc aux2
    inc si
  loop ciclo
    
mov ah, 4ch
int 21h
main endp

m_horizontal proc
  push dx
  cicloH:
    cmp dl, 80
    je finH
    call cursor
    call imprime
    inc dl
    jmp cicloH
  finH:
  pop dx
  ret
m_horizontal endp
  
m_vertical proc
  push dx
  cicloV:
    cmp dh, 25
    je finV
    call cursor
    call imprime
    inc dh
    jmp cicloV
  finV:
  pop dx
  ret
m_vertical endp

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

camino1 proc
  push dx
  paso1:
    cmp dh, 12
    je finC1
    call cursor
    call d_camino
    call retardo
    inc dh
    jmp paso1
  finC1:
  pop dx
  ret
camino1 endp

camino2 proc
  push dx
  paso2:
    cmp dl, 39
    je finC2
    call cursor
    call d_camino
    call retardo
    inc dl
    jmp paso2
  finC2:
  pop dx
  ret
camino2 endp

camino3 proc
  push dx
  paso3:
    cmp dh, 22
    je finC3
    call cursor
    call d_camino
    call retardo
    inc dh
    jmp paso3
  finC3:
  pop dx
  ret
camino3 endp

d_camino proc
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
d_camino endp

camino1_L proc
  push dx
  paso1_L:
    cmp dh, 12
    je finL1
    call cursor
    call d_camino_L
    call retardo
    call d_camino
    call retardo
    inc dh
    jmp paso1_L
  finL1:
  pop dx
  ret
camino1_L endp

camino2_L proc
  push dx
  paso2_L:
    cmp dl, 39
    je finL2
    call cursor
    call d_camino_L
    call retardo
    call d_camino
    call retardo
    inc dl
    jmp paso2_L
  finL2:
  pop dx
  ret
camino2_L endp

camino3_L proc
  push dx
  paso3_L:
    cmp dh, 22
    je finL3
    call cursor
    call d_camino_L
    call retardo
    call d_camino
    call retardo
    inc dh
    jmp paso3_L
  finL3:
  pop dx
  ret
camino3_L endp

d_camino_L proc
  push ax
  push bx
  push cx
  mov bh,0
  mov bl,1Eh
  mov cx,1
  mov ah, 9
  int 10h
  pop cx
  pop bx
  pop ax
  ret
d_camino_L endp

end