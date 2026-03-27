.section .text
.global print_color_string
.global print_string

print_color_string:
    stp x29, x30, [sp, #-32]!
    mov x19, x0
    mov x20, x1
    mov w0, #27; bl put_char
    mov w0, #'['; bl put_char
    mov x1, #10
    udiv x2, x20, x1
    msub x3, x2, x1, x20
    add w0, w2, #'0'; bl put_char
    add w0, w3, #'0'; bl put_char
    mov w0, #'m'; bl put_char
    mov x0, x19; bl print_string
    mov w0, #27; bl put_char
    mov w0, #'['; bl put_char
    mov w0, #'0'; bl put_char
    mov w0, #'m'; bl print_string
    ldp x29, x30, [sp], #32
    ret

print_string:
    stp x29, x30, [sp, #-16]!
    mov x21, x0
1:  ldrb w0, [x21], #1
    cbz w0, 2f
    bl put_char
    b 1b
2:  ldp x29, x30, [sp], #16
    ret

.section .data
.global newline    /* INI KUNCINYA, LOUIS! */
newline: .asciz "\r\n"
