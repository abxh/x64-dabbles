; vim: filetype=nasm

section .data
    pi dq 3.14

section .text
    global circle_area

    circle_area:
        mulsd xmm0, xmm0
        movsd xmm1, [pi]
        mulsd xmm0, xmm1
        ret
