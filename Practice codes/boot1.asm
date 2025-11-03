mov ah, 0x0e

mov al, [the_secret]    ; Here the_secret is just an offset and can't really point towards the actual address
int 0x10             

mov bx, 0x7c0         ; Here we have defined the base value so now the_secret is pointing towards the actual address 
mov ds, bx
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]   ; Here we used es register instead of ds but still this won't work as we have not set it to anything 
int 0x10


mov bx, 0x7c0              ; Here we are using es register but here we are declaring it to be some value more specifically 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db 'X'

; Padding and magic number 
times 510-($-$$) db 0
dw 0xaa55