bits 32
org 0x7c00

xor eax, eax
mov ds, eax
mov es, eax

mov ebx, STRING
call print_VGA

jmp $

%include "Printing_VGA_NoBIOS.asm"

STRING : 
    db 'Hello', 0

times 510-($-$$) db 0
dw 0xaa55