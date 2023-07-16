section .data
    msg1  db "Fibonacci Series:" , 0xa
    len1 equ $-msg1

    msg2  db "Enter the number of terms: " , 0xa
    len2 equ $-msg2

    bye  db "Bye Bye..." , 0xa
    bye_len equ $-bye
    
    term1 db '00'
    term2 db '01'
    term3 db '00'
    maxLength db 1 
    newLine db 0xA
    
    comma db ' , '

    
section .bss
    n resb 4

section .text
    global _start

_start:


    ; Print the prompt 
    mov eax,  4       ; SYS_WRITE 
    mov ebx,  1      ; STDOUT
    mov ecx, msg1 
    mov edx, len1 
    int 0x80 
    
    ;Sys call to input no. of terms to print
    mov eax,  4       ; SYS_WRITE 
    mov ebx,  1      ; STDOUT
    mov ecx, msg2 
    mov edx, len2 
    int 0x80 
    
    ;take input from user
    mov eax,  3      ; SYS_READ 
    mov ebx, 0      ; STDIN
    mov ecx, n 
    mov edx, 4
    int 0x80


    ;print term1
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term1
    mov edx, 2
    int 0x80

    ;print comma
    mov eax, 4      ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, comma
    mov edx, 3
    int 0x80

    mov edi, n

    dec byte[n] 
    cmp byte[n], '0'
    jle end


   



loop:


    ; print nextTerm
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term2 
    mov edx, 2 
    int 0x80
    ;print comma
    mov eax, 4      ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, comma
    mov edx, 3
    int 0x80

        mov     esi, 1      ;pointing to the rightmost digit
        mov     ecx, 2       ;num of digits
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
	
    ; mov eax , [term1]
    ; sub eax,'0'
    ; mov ebx, [term2]
    ; sub ebx,'0'
    ; add eax , ebx 
    ; add eax, '0'

    mov eax , [term3]
    mov ebx, [term2]
    mov [term1] , ebx
    mov [term2] , eax
    
    dec byte[n] 
    cmp byte[n], '0'
    jg loop

; 
end:

    ;print New Line
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, newLine 
    mov edx,1
    int 0x80

    ;print End STATEMENT
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, bye 
    mov edx, bye_len
    int 0x80

    ;exit
    mov eax,  1      ; SYS_EXIT 
    xor ebx,ebx
    int 0x80 
    ret

