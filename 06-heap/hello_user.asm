; vim: filetype=nasm

%define define_bytes db
%define define_qwords dq
%define reserve_bytes resb
%define current_addr $

; ascii encoding:
%define char_null    0
%define char_newline 10

section .bss
    name_len_in_chars reserve_bytes 2

section .data
    length_prompt define_bytes "Name Length (2 digits, no more): ", char_null
    length_prompt_len equ current_addr - length_prompt

    ; name_len_in_chars define_bytes "1", "2"
    name_len_in_chars_len equ 2
    name_str_len define_qwords 0

    name_prompt define_bytes "Name: ", char_null
    name_prompt_len equ current_addr - name_prompt

    greet_prompt_prefix define_bytes "Hello, "
    greet_prompt_prefix_len equ current_addr - greet_prompt_prefix

    greet_prompt_postfix define_bytes "!", char_newline, char_null
    greet_prompt_postfix_len equ current_addr - greet_prompt_postfix

    initial_break define_qwords 0x0

%macro syscall_write_stdout 2
    mov rax, 0x1
    mov rdi, 1  ; stdout
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro syscall_read_stdin 2
    mov rax, 0x0
    mov rdi, 0  ; stdin
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro syscall_exit 1
    mov rax, 0x3c
    mov rdi, %1
    syscall
%endmacro

section .text

    global _start

    _start:
        syscall_write_stdout length_prompt, length_prompt_len
        syscall_read_stdin name_len_in_chars, (name_len_in_chars_len + 1) ; for newline char

        ; for loop to parse int:
        mov rax, 0                                  ; rax <- 0
        mov rbx, 10                                 ; rbx <- 10. (mul cannot use a immediate value. so we use this.)
        mov rcx, 0                                  ; rcx <- 0
        parse_int_loop:
            mul rbx                                 ; rax <- rax * rbx
            mov dl, byte [name_len_in_chars + rcx]  ; rdx <- rdx + name_len_in_chars[rcx]
            sub rdx, "0"                            ; rdx <- rdx - "0"
            add rax, rdx                            ; rax <- rax + rdx

            inc rcx                                 ; rcx <- rcx + 1
            cmp rcx, name_len_in_chars_len          ; compare rcx and name_len_in_chars_len
            jl parse_int_loop                       ; jump if less than

        mov qword [name_str_len], rax               ; *name_str_len <- rax

        ; make room for string. using sources:
        ; https://stackoverflow.com/a/44876873
        ; https://gist.github.com/nikAizuddin/f4132721126257ec4345

        ; get current brk addr:
        mov rax, 0xC ; sys_brk != brk in C
        mov rdi, 0
        syscall
        mov qword [initial_break], rax

        ; allocate bytes on heap:
        mov rdi, qword [initial_break]
        add rdi, qword [name_str_len]
        mov rax, 0xC
        syscall

        syscall_write_stdout name_prompt, name_prompt_len
        syscall_read_stdin qword [initial_break], qword [name_str_len]

        syscall_write_stdout greet_prompt_prefix, greet_prompt_prefix_len
        syscall_write_stdout qword [initial_break], qword [name_str_len]
        syscall_write_stdout greet_prompt_postfix, greet_prompt_postfix_len

        ; free bytes on heap:
        mov rax, 0xC
        mov rdi, qword [initial_break]
        syscall

        syscall_exit 0
