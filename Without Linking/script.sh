nasm -f elf fibonacci.asm                       # assemble the program
ld -m elf_i386 -s -o fibonacci fibonacci.o      # to link the object file and create an executable file  
./fibonacci                                     # runs the executable file