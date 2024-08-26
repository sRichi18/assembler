title
.model small
.stack 100h
.data
  msj1 db "Seleciona la columna: ", "$"
  msj2 db 13, 10, "Escribe la cadena de texto: ", "$"
  columna db ?
  linea db ?

keyboardArea label byte
  maxkeys db 15
  charsInput db ?
  buffer db 32 dup(0)

.code
main proc
  mov ax, @data
  mov ds, ax

  mov dx, offset msj1
  mov ah, 9h
  int 21h

  mov ah, 1h               ;lee numero de la cadena 1-9
  int 21h
  mov columna, al          ;guardamos el valor en la variable columna
  
  mov dx, offset msj2
  mov ah, 9h
  int 21h

  mov ah, 0Ah                  ;lee la cadena y la guarda en el area designada
  mov dx, offset keyboardArea
  int 21h

  mov bx, offset keyboardArea  ;impresion en pantalla
  mov si, 2
  mov cx, 0
  mov cl, [bx+1]
  
  sub columna, 48
  mov linea, 10

  ciclo:
    mov ah, 2h
    mov dh, linea
    mov dl, columna
    mov bh, 0
    int 10h
    inc linea
    
    mov dl, [bx+si]
    mov ah, 2h
    int 21h
    inc si
  loop ciclo
    
  mov ah, 4Ch
  int 21h
main endp

end