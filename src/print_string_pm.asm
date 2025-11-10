BITS 32

VIDEO_MEMORY equ 0xb8000  ; Memory where video memory starts , Also what does equ here mean ?
WHITE_ON_BLACK equ 0x0f

print_string_pm :
    pusha
    mov edx, VIDEO_MEMORY      
    .loop :
        mov al, [ebx]               ; We insert the character at al and the 
        mov ah, WHITE_ON_BLACK      ; properties at ah.

        cmp al, 0
        je .end

        mov [edx], ax               ; Copying the 2 bytes into edx
        add ebx, 1
        add edx, 2
        jmp .loop 

    .end : 
        popa
        ret