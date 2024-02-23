; vim: filetype=nasm

section .text

    global npow

    npow:
        push rbp                    ; push base pointer
        mov rbp, rsp                ; use base pointer as stack pointer
        sub rsp, 16                 ; allocate 16 bytes on stack

        %define base     qword [rbp - 8]
        %define exponent qword [rbp - 16]

        mov base, rdi               ; base <- rdi (param1)
        mov exponent, rsi           ; exponent <- rsi (param2)

        cmp exponent, 0             ; compare exponent and 0
        je case_zero                ; jump if equal

        mov rax, exponent           ; rax <- exponent
        and rax, 1                  ; rax <- rax & 1
        cmp rax, 1                  ; compare rax and 1
        je case_odd                 ; jump if equal

        case_even:
            shr exponent, 1         ; rax <- exponent >> 1

            mov rdi, base           ; rdi (param1) <- base
            mov rsi, exponent       ; rsi (param2) <- exponent
            call npow               ; rax <- npow(base, exponent)

            mul rax                 ; rax <- rax * rax

            mov rsp, rbp            ; deallocate 16 bytes from stack
            pop rbp                 ; pop stack and restore base pointer
            ret                     ; return rax

        case_odd:
            dec exponent            ; exponent <- exponent - 1
            shr exponent, 1         ; exponent <- exponent >> 1

            mov rdi, base           ; rdi <- base
            mov rsi, exponent       ; rsi <- exponent
            call npow               ; rax <- npow(base, exponent)

            mul rax                 ; rax <- rax * rax
            mul base                ; rax <- rax * base

            mov rsp, rbp            ; deallocate 16 bytes from stack
            pop rbp                 ; pop stack and restore base pointer
            ret                     ; return rax

        case_zero:
            mov rax, 1              ; rax <- 1

            mov rsp, rbp            ; deallocate 16 bytes from stack
            pop rbp                 ; pop stack and restore base pointer
            ret                     ; return rax
