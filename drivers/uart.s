.section .text
.global uart_putc
.global uart_getc
.global print_string

uart_putc:
    mov x1, #0x09000000
1:  ldr w2, [x1, #0x18]
    tst w2, #0x20
    b.ne 1b
    str w0, [x1]
    ret

uart_getc:
    mov x1, #0x09000000
1:  ldr w2, [x1, #0x18]
    tst w2, #0x10
    b.ne 1b
    ldr w0, [x1]
    ret

print_string:
    stp x29, x30, [sp, #-16]!
    mov x19, x0
2:  ldrb w0, [x19], #1
    cbz w0, 3f
    bl uart_putc
    b 2b
3:  ldp x29, x30, [sp], #16
    ret

.section .data
.global newline
newline: .asciz "\r\n"
