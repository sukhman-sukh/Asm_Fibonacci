section .data
    msg1  db "Fibonacci Series:" , 0xa
    len1 equ $-msg1

    msg2  db "Enter the number of terms: " , 0xa
    len2 equ $-msg2

    msg3 db "Wrong entry !  Try Again !! "
    len3 equ $-msg3

    bye  db "Bye Bye..." , 0xa
    bye_len equ $-bye

    term1 db '000'
    term2 db '001'
    term3 db '000'
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



    mov edx , n
    cmp byte[n] , 48
    jle err1
    cmp byte[n] , 57
    jg err1


    ;convert string to int
    call atoi
    mov edi,eax

    cmp edi , 17
    jg err1

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



    

atoi:
    mov eax, 0              ; Set initial total to 0
    mov esi , 0 
convert:
    movzx esi, byte[edx]   ; Get the current character
    
    cmp byte[edx+1] ,0
    je done

    
    cmp esi, 48             ; Anything less than 0 is invalid
    jl error
    
    cmp esi, 57             ; Anything greater than 9 is invalid
    jg error
     
    sub esi, 48             ; Convert from ASCII to decimal 
    imul eax, 10            ; Multiply total by 10
    add eax, esi            ; Add current digit to total
    
    inc edx                  ; Get the address of the next character
    jmp convert

error:
    mov eax, -1             ; Return -1 on error
 
done:
    ret                     ; Return total or error code



err1:
    ;print End STATEMENT
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, msg3 
    mov edx, len3
    int 0x80

    call _start