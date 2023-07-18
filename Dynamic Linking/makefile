all: fib

fib: fib.o  libFib.so setEnvVariable
	gcc main.c -o fib -lfib -L lib
	./fib

libFib.so: makeDir fib.o
	gcc -m32 -shared fib.o -o libFib.so	
	mv libFib.so lib

fib.o: fib.asm
	nasm -f elf fib.asm -o fib.o

makeDir:
	mkdir -p lib 

setEnvVariable:
    $(eval current_dir := $(shell pwd))
    export LD_LIBRARY_PATH=$(current_dir)/lib

clean:
	rm -rf fib fib.o lib 