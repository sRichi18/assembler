.model small
.stack 100h
.data
aux1 dw ?
letra_minus db ?
letra_mayus db ?

.code
main proc
  mov ax, @data
  mov ds, ax

  ;Dibujar Marco
  call m_Horizontal_1
  call m_Horizontal_2
  call m_Horizontal_3
  call m_Horizontal_4

  call m_Vertical_1
  call m_Vertical_2
  call m_Vertical_3
  call m_Vertical_4

  ;Imprimir Letras
  mov bx, 486
  mov aux1, 538
  mov cx, 556

  ciclo:
    mov ah, 08h
    int 21h

    cmp al, 27    ;Valor de Esc en ASCCI
    je Fin
    
    cmp bx, 1978  ;Limite del area de escritura 
    je Fin

    cmp bx, aux1
    je nueva_linea
    
    desplegar:
      cmp al, 97
      jl mayuscula
    
      ;comvertir minuscula a mayuscula
      mov dl, al
      sub al, 32
      mov dh, al
      call imprime_minus
      add bx, 2
      call imprime_mayus
      add cx, 2
      jmp ciclo

      ;comvertir mayuscula a minuscula
      mayuscula:
        mov dh, al
        add al, 32
        mov dl, al
        call imprime_minus
        add bx, 2
        call imprime_mayus
        add cx, 2
        jmp ciclo
      
    nueva_linea:
      add aux1, 160
      add bx, 108
      add cx, 108
      jmp desplegar

Fin:
mov ah, 4ch
int 21h

main endp

m_Horizontal_1 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 324
  ciclo_H1:
   cmp di, 380
   je fin_H1 
   mov es:[di], 205
   mov es:[di + 1], 4Fh
   add di, 2
   jmp ciclo_H1

  fin_H1:
  pop es
  pop dx
  pop ax
  ret
m_horizontal_1 endp

m_Horizontal_2 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 2084
  ciclo_H2:
   cmp di, 2140
   je fin_H2 
   mov es:[di], 205
   mov es:[di + 1], 4Fh
   add di, 2
   jmp ciclo_H2

  fin_H2:
  pop es
  pop dx
  pop ax
  ret
m_horizontal_2 endp

m_Horizontal_3 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 394
  ciclo_H3:
   cmp di, 450
   je fin_H3 
   mov es:[di], 205
   mov es:[di + 1], 4Fh
   add di, 2
   jmp ciclo_H3

  fin_H3:
  pop es
  pop dx
  pop ax
  ret
m_horizontal_3 endp

m_Horizontal_4 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 2154
  ciclo_H4:
   cmp di, 2210
   je fin_H4 
   mov es:[di], 205
   mov es:[di + 1], 4Fh
   add di, 2
   jmp ciclo_H4

  fin_H4:
  pop es
  pop dx
  pop ax
  ret
m_horizontal_4 endp

m_Vertical_1 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 484
  ciclo_V1:
   cmp di, 2084
   je fin_V1 
   mov es:[di], 186
   mov es:[di + 1], 4Fh
   add di, 160
   jmp ciclo_V1

  fin_V1:
  pop es
  pop dx
  pop ax
  ret
m_Vertical_1 endp

m_Vertical_2 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 538
  ciclo_V2:
   cmp di, 2138
   je fin_V2 
   mov es:[di], 186
   mov es:[di + 1], 4Fh
   add di, 160
   jmp ciclo_V2

  fin_V2:
  pop es
  pop dx
  pop ax
  ret
m_Vertical_2 endp

m_Vertical_3 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 554
  ciclo_V3:
   cmp di, 2154
   je fin_V3 
   mov es:[di], 186
   mov es:[di + 1], 4Fh
   add di, 160
   jmp ciclo_V3

  fin_V3:
  pop es
  pop dx
  pop ax
  ret
m_Vertical_3 endp

m_Vertical_4 proc
  push ax
  push dx
  push es
  mov ax, 0B800h
  mov es, ax
  
  mov di, 608
  ciclo_V4:
   cmp di, 2208
   je fin_V4 
   mov es:[di], 186
   mov es:[di + 1], 4Fh
   add di, 160
   jmp ciclo_V4

  fin_V4:
  pop es
  pop dx
  pop ax
  ret
m_Vertical_4 endp

imprime_minus proc
  push ax
  push dx
  push es
  
  mov ax, 0B800h
  mov es, ax
  
  mov di, bx 
  mov es:[di], dl
  mov es:[di + 1], 1Eh

  pop es
  pop dx
  pop ax
  ret  
imprime_minus endp

imprime_mayus proc
  push ax
  push dx
  push es
  
  mov ax, 0B800h
  mov es, ax
  
  mov di, cx 
  mov es:[di], dh
  mov es:[di + 1], 1Eh

  pop es
  pop dx
  pop ax
  ret  
imprime_mayus endp

end main