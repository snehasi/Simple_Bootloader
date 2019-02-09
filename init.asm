SwitchToLongMode:
    push di                           
    mov ecx, 0x1000
    xor eax, eax
    cld
    rep stosd
    pop di                            
    
    lea eax, [es:di + 0x1000]         
    or eax, PAGE_PRESENT | PAGE_WRITE 
    mov [es:di], eax                  
 
    lea eax, [es:di + 0x2000]         
    or eax, PAGE_PRESENT | PAGE_WRITE 
    mov [es:di + 0x1000], eax         
 
    lea eax, [es:di + 0x3000]         
    or eax, PAGE_PRESENT | PAGE_WRITE 
    mov [es:di + 0x2000], eax         

    push di                           
    lea di, [di + 0x3000]             
    mov eax, PAGE_PRESENT | PAGE_WRITE    
    
.LoopPageTable:
    mov [es:di], eax
    add eax, 0x1000
    add di, 8
    cmp eax, 0x200000                 
    jb .LoopPageTable
 
    pop di                            
    
    mov al, 0xFF                      
    out 0xA1, al
    out 0x21, al
 
    nop
    nop
 
    lidt [IDT]                        
    
    mov eax, 0xA0                
    mov cr4, eax
 
    mov edx, edi                      
    mov cr3, edx
 
    mov ecx, 0xC0000080               
    rdmsr    
 
    or eax, 0x00000100                
    wrmsr
 
    mov ebx, cr0                      
    or ebx, 0x80000001                 
    mov cr0, ebx                    
 
    lgdt [GDT.Pointer]                
 
    jmp CODE_SEG:LongMode             
 
    
GDT:
.Null:
    dq 0x0000000000000000             
 
.Code:
    dq 0x00209A0000000000             
    dq 0x0000920000000000