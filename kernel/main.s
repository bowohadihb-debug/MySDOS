.section .text
.global _start

_start:
    ldr x0, =0x40100000
    mov sp, x0

    ldr x0, =boot_msg
    bl print_string

shell_loop:
    bl uart_getc
    /* Filter karakter aneh (opsional) */
    cmp w0, #32
    blt shell_loop
    
    bl uart_putc         /* Echo */
    b shell_loop

print_string:
    stp x29, x30, [sp, #-16]!
    mov x20, x0
ps_next:
    ldrb w0, [x20], #1
    cbz w0, ps_done
    bl uart_putc
    b ps_next
ps_done:
    ldp x29, x30, [sp], #16
    ret

.include "drivers/uart.s"

.section .data
boot_msg: .asciz "\r\n[MySDOS v3.2.2] UART Fixed.\r\nLouis@MySDOS> "
