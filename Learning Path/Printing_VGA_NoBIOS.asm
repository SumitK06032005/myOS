BITS 32

VIDEO_MEMORY equ 0xb8000  ; Memory where video memory starts , Also what does equ here mean ?
WHITE_ON_BLACK equ 0x0f

mov edx, VIDEO_MEMORY

print_VGA :
    pusha
    mov edx, VIDEO_MEMORY
    .loop :
        mov al, [ebx]
        mov ah, WHITE_ON_BLACK

        cmp al, 0
        je .end

        mov [edx], ax
        add ebx, 1
        add edx, 2
        jmp .loop 

    .end : 
        popa
        ret

    