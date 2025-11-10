print_string:
    push ax
    push bx
    .loop:
        mov al, [bx]           ; Here bx register acts like an offset
        cmp al, 0              ; in the case of string operations and 
        je .end                ; our ds register has already been set to 0

        mov ah, 0x0e
        int 0x10
        inc bx
        jmp .loop

    .end:
        pop ax 
        pop bx
        ret