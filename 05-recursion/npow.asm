; vim: filetype=nasm

section .text

    global npow

    npow:
        push rbp                    ; push base pointer
        mov rbp, rsp                ; use base pointer as stack pointer
        sub rsp, 16                 ; allocate 16 bytes on stack

        cmp rsi, 0                  ; compare rsi (exponent) and 0
        je case_zero                ; jump if equal

        %define base     qword [rbp - 8]
        %define exponent qword [rbp - 16]

        mov base, rdi               ; base <- rdi (param1)
        mov exponent, rsi           ; exponent <- rsi (param2)

        test exponent, 1            ; _ <- exponent & 1
        jnz case_odd                ; jump if non-zero

        case_even:
            shr exponent, 1         ; rax <- exponent >> 1

            mov rdi, base           ; rdi (param1) <- base
            mov rsi, exponent       ; rsi (param2) <- exponent
            call npow               ; rax <- npow(base, exponent)

            mul rax                 ; rax <- rax * rax

            mov rsp, rbp            ; deallocate 16 bytes from stack. restore stack pointer.
            pop rbp                 ; pop stack and restore base pointer
            ret                     ; return rax

        case_odd:
            dec exponent            ; exponent <- exponent - 1
            shr exponent, 1         ; exponent <- exponent >> 1

            mov rdi, base           ; rdi (param1) <- base
            mov rsi, exponent       ; rsi (param2) <- exponent
            call npow               ; rax <- npow(base, exponent)

            mul rax                 ; rax <- rax * rax
            mul base                ; rax <- rax * base

            mov rsp, rbp            ; deallocate 16 bytes from stack. restore stack pointer.
            pop rbp                 ; pop stack and restore base pointer
            ret                     ; return rax

        case_zero:
            mov rax, 1              ; rax <- 1
            ret                     ; return rax
