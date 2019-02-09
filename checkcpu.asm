BITS 16

CheckCPU:
    
    pushfd                            
 
    pop ebx
    mov ecx, ebx  
    xor ebx, 0x200000 
    push ebx 
    popfd
 
    pushfd 
    pop ebx
    xor ebx, ecx
    shr ebx, 21 
    and ebx, 1                        
    push ecx
    popfd 
 
    test ebx, ebx
    jz .NoLongMode
 
    mov eax, 0x80000000   
    cpuid                 
 
    cmp eax, 0x80000001               
    jb .NoLongMode
 
    mov eax, 0x80000001  
    cpuid                 
    test edx, 1 << 29                 
    jz .NoLongMode                    
 
    ret
 