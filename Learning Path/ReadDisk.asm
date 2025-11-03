mov ah, 0x02   ; BIOS read sector function

mov dl, 0x0000 ; read drive 0
mov ch, 3    ; read cylinder 3
mov dh, 1     ; use the second head 
mov cl, 4    ; read 4th sector
mov al, 5    ; read 5 sectors

mov bx, 0xa000   ; location to read the sectors to 
mov es, bx
mov bx, 0x1234


int 0x13   ; interrupt to read sectors

jc disk_error   ; jump in case the carry flag is raised

cmp al, 5    ; comparing actual sectors read no. stored in al
jne disk_error  ; stored in al with the expected no.

call print_string

jmp $

disk_error :
    mov bx, disk_msg
    call print_string
    jmp $

%include "print_string.asm"

disk_msg : 
    db 'Disk read error', 0

; Padding and magic number 
times 510-($-$$) db 0
dw 0xaa55
