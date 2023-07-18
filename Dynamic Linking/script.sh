mkdir -p lib
# Create object file for assembly code
nasm -f elf fib.asm -o fib.o

# Create Shared Library
gcc -m32 -shared fib.o -o fibLib.so
mv fibLib.so lib

current_dir=$(pwd)
export LD_LIBRARY_PATH=${current_dir}/lib

# 
gcc -c main.c -o fibonacci -lfib -L lib
