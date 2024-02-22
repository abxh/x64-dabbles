; vim: filetype=nasm

%define SYS_EXIT 60
%define EXIT_SUCCESS 0

section .text

    global _start

    extern get_num
    extern print_num
    extern nsum

    _start:
        call get_num          ; rax <- get_num()
        mov rdi, rax          ; rdi <- rax
        call nsum             ; rax <- nsum(rdi);
        mov rdi, rax          ; rdi <- rax
        call print_num        ; print_num(rdi)

        ; sys_exit(exit_success)
        mov rax, SYS_EXIT
        mov rdi, EXIT_SUCCESS
        syscall
