%include "my_print_function.asm"   
                                ; Here we I was learning how to include 
mov al, 'H'                     ; files so that we won't have to rewrite 
call my_print_function          ; repetitive codes.
jmp $

times 510-($-$$) db 0
dw 0xaa55