; A boot sector that enters 32 bit protected mode.
[org 0x7c00]

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm

jmp $

%include "print_string.asm"
%include "switch_to_pm.asm"
%include "print_string_pm.asm"
%include "gdt.asm"

[bits 32]

; This is where we land after initializing pm
BEGIN_PM :

mov ebx, MSG_PM
call print_string_pm

jmp $

; Global var
MSG_REAL_MODE : db "Started in 16-bit real mode", 0
MSG_PM : db "Successfully landed in 32-bit protected mode", 0

; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55