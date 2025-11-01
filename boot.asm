mov al, 'H'                      ; Here I was learning how to  
call my_print_function           ;  how to implement calling a func in asm
call some_function

my_print_function:
    mov ah, 0x0e
    int 0x10
    ret


some_function :                  ; Sometimes, I mean a lot of times
    pusha                        ; Register values are altered cause of
    mov bx, 10                   ; our programming in asm and thus we 
    add bx, 20                   ; are pushing and poping their original values
    mov ah, 0x0e                 ; into stack to save them from being lost :)
    int 0x10
    popa
    ret

times 510-($-$$) db 0
dw 0xaa55