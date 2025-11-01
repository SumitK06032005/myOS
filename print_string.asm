print_string :
    mov ah, 0x0e
    .loop :
        add bx, 0x7c00
        mov al, [bx]
        cmp al, 0
        je .end
        int 0x10
        inc [bx]
        jmp .loop
    .end :
        ret