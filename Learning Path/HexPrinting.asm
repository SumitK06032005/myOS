org 0x7c00
bits 16

start : 
    xor ax, ax      ; Initialize segment registers
    mov ds, ax
    mov es, ax

    mov dx, 0x1fb6
    call hex_print
    jmp $            ; Keeping this to hang the bootloader 

hex_print:
    push ax           ; Pushing the registers to keep their values 
    push bx           ; safe even if something happens to them in 
    push cx            ; in the functions
    push dx

    mov bx, HEX_OUT + 5  ; Here we are basically pointing to the last digit of HEX_OUT
    mov cx, 4    ; cx here acts like a counter for us 

    .loop:
        mov ax, dx    ; here we are copying dx to ax so that we can act on the values
        and ax, 0x000F ; here we are basically getting the last 4 digits of the binary
                         ; that makes one letter in the hexadecimal
        cmp al, 9
        jle .digit

        add al, 'a'-10   ; here we wanted a number that can convert any larger number to 
        jmp .store        ; ASCII by adding it or subtracting it so we got 55
                           ; 10 and so any number added to 48 would give their ascii code.
    .digit :
        add al, '0' ; here '0' is 48 in ascii code, we wanted to get ascii of every number less 
        jmp .store

    .store :
        mov [bx], al      ; storing those single characters to those locations 
        dec bx           ; here we are decreasing bx to go to the predecessor 0 
        shr dx,4         ; here we are basically shifting dx right side by 4 digits 
                       ; to basically get all next digit in the last 4 bits position.
        loop .loop      ; loop commands dec - cx , checks if its 0 and if 0 exits loop
         
        mov bx, HEX_OUT    ; printing the final stored values
        call print_string

    pop ax
    pop bx
    pop cx
    pop dx
    ret

%include 'print_string.asm'

HEX_OUT:
    db '0x0000', 0


; Padding and magic number 
times 510-($-$$) db 0
dw 0xaa55


