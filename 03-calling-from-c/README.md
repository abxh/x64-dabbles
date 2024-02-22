# calling from c

I did the following to create executable binary:

1. `nasm nsum.asm`
2. `gcc -c io_handler.c`
3. `gcc nsum.o io_handler.o`

Sidenote:<br>
You can also do `gcc nsum.o io_handler.c` (or the sorts)
for convenience.
