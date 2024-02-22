; vim: filetype=nasm

section .text

    global nsum

    nsum:
        mov rax, rdi ; rax <- rdi
        mul rdi      ; rax <- rax * rdi
        add rax, rdi ; rax <- rax + rdi
        shr rax, 1   ; rax <- rax >> 1
        ret          ; ret rax
