
.global _start
.intel_syntax noprefix

_start:
    // sys_exit 42 (kernel syscall)
    mov rax, 0x3c
    mov rdi, 42
    syscall
