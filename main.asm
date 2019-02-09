%define FREE_SPACE 0x9000
    
ORG 0x7C00
BITS 16
 
Main:
    jmp 0x0000:.FlushCS               

.FlushCS:   
    xor cx, cx
    xor cx, cx

    mov ss, cx
    xor cx, cx
    
    mov sp, Main
 
    xor cx, cx
    mov ds, cx
    mov es, cx
    mov fs, cx
    mov gs, cx
    cld
 
    call CheckCPU                     
    jc .NoLongMode
    
    mov edi, FREE_SPACE
    
    jmp SwitchToLongMode
 
BITS 64
.Long:
    hlt
    jmp .Long
 
 
BITS 16
 
.NoLongMode:
    mov si, NoLongMode
 
.Die:
    hlt
    jmp .Die
 
 
%include "boot.asm"
BITS 16
 
NoLongMode db "ERROR: CPU does not support long mode.", 0x0A, 0x0D, 0

%include "checkcpu.asm"

BITS 16
.NoLongMode:
    stc
    ret
 
times 510 - ($-$$) db 0
db 0x55
db 0xAA
