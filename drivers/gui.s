.section .text
.global draw_window

/* x0 = Width, x1 = Height, x2 = Title (String) */
draw_window:
    stp x29, x30, [sp, #-32]!
    mov x19, x0     /* Simpan Width */
    mov x20, x1     /* Simpan Height */
    mov x21, x2     /* Simpan Title */

    /* 1. Gambar Top Border */
    mov w0, #'+'; bl uart_putc
    mov x22, x19
1:  mov w0, #'-'; bl uart_putc
    subs x22, x22, #1
    b.ne 1b
    mov w0, #'+'; bl uart_putc
    adr x0, newline; bl print_string

    /* 2. Gambar Title Bar */
    mov w0, #'|'; bl uart_putc
    mov x0, x21;  bl print_string
    mov w0, #'|'; bl uart_putc
    adr x0, newline; bl print_string

    /* 3. Gambar Bottom Border */
    mov w0, #'+'; bl uart_putc
    mov x22, x19
2:  mov w0, #'-'; bl uart_putc
    subs x22, x22, #1
    b.ne 2b
    mov w0, #'+'; bl uart_putc
    adr x0, newline; bl print_string

    ldp x29, x30, [sp], #32
    ret
