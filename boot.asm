;
; Printing a string 
;

[org 0x7c00]
%include 'print_string.asm'
start :
    mov bx, MSG1
    call print_string

    mov bx, MSG2
    call print_string

    jmp $

; Data
MSG1 :
    db 'Hello, World',0

MSG2 :
    db 'Goodbye',0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55