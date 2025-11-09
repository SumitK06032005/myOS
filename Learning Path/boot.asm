[BITS 16]
[ORG 0x7C00]

start:
    ; CRITICAL: Initialize segment registers first!
    xor ax, ax
    mov ds, ax      ; DS = 0 (needed for accessing DISK_ERROR_MSG)
    mov es, ax      ; ES = 0 (we'll use 0:0x9000 as read destination)
    
    ; Set up stack (good practice)
    mov bp, 0x8000
    mov sp, bp
    
    ; Print starting message
    mov bx, READ_MSG
    call print_string
    call print_newline
    
    ; === BIOS DISK READ ===
    mov ah, 0x02    ; BIOS read sector function
    mov dl, 0x80    ; Drive 0x80 = first hard disk (0x00 = first floppy)
    mov ch, 0       ; Cylinder 0 (safer to start from beginning)
    mov dh, 0       ; Head 0 (first side)
    mov cl, 2       ; Sector 2 (sector 1 is THIS bootloader!)
    mov al, 1       ; Read 1 sector (512 bytes)
    
    ; Set destination: ES:BX = 0:0x9000
    ; Physical address = 0x0000 * 16 + 0x9000 = 0x9000
    mov bx, 0x9000  ; ES already = 0
    
    int 0x13        ; Issue BIOS disk read interrupt
    
    ; === CHECK FOR ERRORS ===
    jc disk_error   ; Jump if carry flag set (error occurred)
    
    ; Check if correct number of sectors read
    cmp al, 1       ; AL should contain 1 (sectors read)
    jne disk_error  ; If not equal, there was an error
    
    ; === SUCCESS! ===
    mov bx, SUCCESS_MSG
    call print_string
    call print_newline
    
    ; Print first byte of what we read (as proof)
    mov bx, READ_DATA_MSG
    call print_string
    
    mov dx, [0x9000]    ; Load first 2 bytes from where we read
    call print_hex
    call print_newline
    
    jmp $           ; Hang forever
    
disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    call print_newline
    jmp $

; ============================================
; Function: print_string
; Input: BX = pointer to null-terminated string
; ============================================
print_string:
    push ax
    push bx
    
.loop:
    mov al, [bx]
    cmp al, 0
    je .done
    
    mov ah, 0x0E
    int 0x10
    
    inc bx
    jmp .loop
    
.done:
    pop bx
    pop ax
    ret

; ============================================
; Function: print_newline
; ============================================
print_newline:
    push ax
    
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    
    mov al, 0x0A
    int 0x10
    
    pop ax
    ret

; ============================================
; Function: print_hex
; Input: DX = 16-bit value to print as hex
; ============================================
print_hex:
    push ax
    push bx
    push cx
    push dx
    
    mov cx, 4
    mov bx, HEX_OUT + 5
    
.loop:
    mov ax, dx
    and ax, 0x000F
    
    cmp ax, 9
    jle .digit
    
    add al, 'A' - 10
    jmp .store
    
.digit:
    add al, '0'
    
.store:
    mov [bx], al
    dec bx
    shr dx, 4
    
    loop .loop
    
    mov bx, HEX_OUT
    call print_string
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; ============================================
; Data Section
; ============================================
READ_MSG:       db 'Attempting disk read...', 0
SUCCESS_MSG:    db 'Disk read successful!', 0
DISK_ERROR_MSG: db 'Disk read error!', 0
READ_DATA_MSG:  db 'First 2 bytes read: ', 0
HEX_OUT:        db '0x0000', 0

; ============================================
; Boot Sector Signature
; ============================================
times 510-($-$$) db 0
dw 0xAA55