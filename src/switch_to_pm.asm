[bits 16]

switch_to_pm:           ; Switching to protected mode
    
    cli                 ; Clearing all interrupts until we 
                        ; have setup our protected mode
    
    lgdt [gdt_descriptor]


    mov eax, cr0        ; To make the switch to pm we get 
    or eax, 0x1         ; the first bit of CR0
    mov cr0, eax

    jmp CODE_SEG:init_pm   ; Make a far jump to our 32 bit
                           ; code.

[bits 32]
; Initialize registers and the stack once in PM 
init_pm:

    mov ax, DATA_SEG       ; We point our segment registers
    mov ds, ax                        ; to the data segement we defined
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9000         ; Update our stack pointers as well 
    mov esp, ebp            ; to the top of the free space

    call BEGIN_PM
    