section .data
    msg1  db "Fibonacci Series:" , 0xa
    len1 equ $-msg1

    msg2  db "Enter the number of terms: " , 0xa
    len2 equ $-msg2

    bye  db "Bye Bye..." , 0xa
    bye_len equ $-bye
    
    maxLength db 1 
    
section .bss
    n resb 1 
    term1 resb 1 
    term2 resb 1 
    term3 resb 1 

section .text
    global _start

_start:

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
    mov ebx, 0       ; STDIN
    mov ecx, n 
    mov edx, maxLength
    int 0x80

    ;initialize term1 and term2
    mov byte [term1], 0x0
    mov byte [term2], 0x1

    ;print term1
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term1 
    mov edx, 0x1 
    int 0x80

    ;Condition1
    cmp byte [n], 1
    jle end


    mov ecx , n



loop:
    ;print nextTerm
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, term2 
    mov edx, 0x1 
    int 0x80

    mov byte[term3], term1
    mov byte[term1], term2
    add byte[term2], term3  
    mov byte [term3],0

    dec ecx
    cmp ecx, 0
    jne loop

end:

    ;print End STATEMENT
    mov eax, 4       ; SYS_WRITE 
    mov ebx, 1      ; STDOUT
    mov ecx, bye 
    mov edx, bye_len
    int 0x80

    ;exit
    mov eax,  1      ; SYS_EXIT 
    mov ebx , 0
    int 0x80 

