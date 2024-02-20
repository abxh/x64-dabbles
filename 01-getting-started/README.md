# Getting started

I in general followed along this [video](https://www.youtube.com/watch?v=6S5KRJv-7RU) for the assembly code.

The following are the things I done to compile, debug and get a better sense of how things work:

## Exit successfully

1. Run `as exit.S -o exit.o`.
2. Link file(s) together with `ld exit.o -o exit.out`.
3. Check the exit code with `echo $?`.
4. Disassemble executable file to intel-style assembly with `objdump -M intel -d exit.out`.

## "Hello World" program

1. Run `as hello_world.S -o hello_world.o`.
2. Link file(s) together with `ld hello_world.o -o hello_world.out`.
3. Disassemble executable file to intel-style assembly with `objdump -M intel -dz hello_world.out`.
   (`-z` to include padding or `nop` instructions)
4. Disassemble entire file with `-Dz` instead. Run `hexdump -C` to attempt to read the asci bytes and other things.

It's interesting to look at `hexdump -C hello_world.o`.

## Debugging the "Hello World" progra

For this part, I used this [article](https://www.cs.swarthmore.edu/~newhall/cs31/resources/ia32_gdb.php).

1. Assemble with debug information by providing `-g` to `as`. And do the process of assembling and linking.
2. Run `gdb <your program>`.
3. `set disassembly-flavor intel`.
4. Set a breakpoint to the memory location `_start` with `break _start`.
5. Do the other things mentioned in the article.

It's interesting to see how to disassemble C code in this [video](https://www.youtube.com/watch?v=Dq8l1_-QgAc).
