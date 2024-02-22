# calling c functions from assembly

I did the following to create executable binary:

1. `nasm glue.asm`
2. `gcc -c *.c`
3. `gcc -nostartfiles *.o`

`-nostartfiles` makes it so `gcc` does not complain about
a missing `main` function.

> Small Sidenote:<br>
> Since windows executables use a different calling convention,
> you might need to e.g. replace `mov rdi, rax` with `mov rcx, rax` along with other things.
