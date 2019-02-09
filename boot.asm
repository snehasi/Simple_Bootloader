%define PAGE_PRESENT    (1 << 0)
%define PAGE_WRITE      (1 << 1)
 
%define CODE_SEG     0x0008
%define DATA_SEG     0x0010
 
ALIGN 4
IDT:
    .Length       dw 0
    .Base         dd 0
 
%include "init.asm"
 
ALIGN 4
    dw 0           
 
.Pointer:
    dw $ - GDT - 1                    
    dd GDT                            
 
 
[BITS 64]      
LongMode:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
 
    
    mov edi, 0xB8000
    mov rcx, 500                      
    mov rax, 0x1F201F201F201F20       
    rep stosq                         
 
    mov edi, 0x00b8000              
    
    mov rax, 0x1F6C1F6C1F651F48    
    mov [edi],rax
 
    mov rax, 0x1F6F1F571F201F6F
    mov [edi + 8], rax
 
    mov rax, 0x1F201F641F6C1F72
    mov [edi + 16], rax
    
    mov rax, 0x1F201F331F521F43
    mov [edi + 24], rax
    
    mov rax, 0x1F301F301F301F30
    mov [edi + 32], rax
    
    mov rax, 0x1F301F301F301F30
    mov [edi + 40], rax
    
    jmp Main.Long  
