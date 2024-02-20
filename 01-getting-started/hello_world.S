
.global _start
.intel_syntax noprefix

_start:
    // sys_write stdout hello_world sizeof(hello_world)
    mov rax, 0x1
    mov rdi, 1
    lea rsi, hello_world
    mov rdx, 14
    syscall

    // sys_exit exit_code
    mov rax, 0x3c
    mov rdi, 0
    syscall

hello_world:
    .asciz "Hello World!\n"
