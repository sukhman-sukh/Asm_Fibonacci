section .data
    term1 db '000'
    term2 db '001'
    term3 db '000'
    comma db ' , '

section .text
global fibo: function

fibo:
        ;print term1
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term1
    mov edx, 3
    int 0x80

    ;print comma
    mov eax, 4      ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, comma
    mov edx, 3
    int 0x80

    sub edi , 0x1
    cmp edi ,0
    jle end


   



loop:


    ; print nextTerm
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term2 
    mov edx, 3 
    int 0x80
    ;print comma
    mov eax, 4      ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, comma
    mov edx, 3
    int 0x80

    mov     esi, 2      ;pointing to the rightmost digit
    mov     ecx, 3       ;num of digits
    clc
   
    add_loop:  
        mov 	al, [term1 + esi]
        adc 	al, [term2 + esi]
        aaa
        pushf
        or 	al, 30h
        popf
	
        mov	[term3 + esi], al
        dec	esi
        loop	add_loop

    mov eax , [term3]
    mov ebx, [term2]
    mov [term1] , ebx
    mov [term2] , eax


    sub edi , 0x1
    cmp edi ,0
    jg loop


end:

    ret

