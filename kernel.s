.section .text
.global _start

_start:
    ldr x0, =0x40110000
    mov sp, x0
    adr x0, msg_boot; bl print_string

shell_reset:
    ldr x20, =cmd_buffer
    mov x21, #0
    adr x0, prompt; bl print_string

shell_loop:
    bl  uart_getc
    cmp w0, #13;  beq handle_enter
    cmp w0, #127; beq handle_backspace
    cmp w0, #8;   beq handle_backspace
    
    cmp w0, #32;  blt shell_loop
    cmp x21, #63; bge shell_loop
    
    strb w0, [x20, x21]
    add  x21, x21, #1
    bl   uart_putc
    b    shell_loop

handle_backspace:
    cbz x21, shell_loop
    sub x21, x21, #1
    mov w0, #8; bl uart_putc; mov w0, #32; bl uart_putc; mov w0, #8; bl uart_putc
    b   shell_loop

handle_enter:
    mov w1, #0; strb w1, [x20, x21]
    adr x0, newline; bl print_string
    cbz x21, shell_reset
    
    ldrb w1, [x20]
    cmp w1, #'l'; beq do_ls
    cmp w1, #'e'; beq do_echo
    cmp w1, #'a'; beq do_calc
    cmp w1, #'v'; beq do_ver
    
    adr x0, msg_unknown; bl print_string
    b   shell_reset

do_ls:   bl fs_list_files; b shell_reset
do_echo: bl run_echo; b shell_reset
do_calc: bl run_calc; b shell_reset
do_ver:  adr x0, msg_ver; bl print_string; b shell_reset

/* --- Drivers --- */
uart_putc:
    ldr x1, =0x09000000
1:  ldr w2, [x1, #0x18]; tst w2, #0x20; bne 1b
    str w0, [x1]; ret

uart_getc:
    ldr x1, =0x09000000
1:  ldr w2, [x1, #0x18]; tst w2, #0x10; bne 1b
    ldr w0, [x1]; ret

/* 🔥 Fungsi Sapu Jagat UART */
.global deep_flush_uart
deep_flush_uart:
    ldr x1, =0x09000000
1:  ldr w2, [x1, #0x18]
    tst w2, #0x10      /* RXFE (FIFO empty?) */
    bne 2f
    ldr w0, [x1, #0x00] /* Baca dan buang */
    b   1b
2:  ret

print_string:
    stp x29, x30, [sp, #-16]!
    mov x19, x0
1:  ldrb w0, [x19], #1; cbz w0, 2f; bl uart_putc; b 1b
2:  ldp x29, x30, [sp], #16; ret

.include "drivers/fs.s"
.include "program/calc.s"
.include "program/echo.s"

.section .data
msg_boot:    .asciz "\r\n[MySDOS v0.0.6.8] Bugfix: Ghost Enter\r\n"
msg_ver:     .asciz "MySDOS v0.0.6.8 (C) 2026 Louis\r\n"
msg_unknown: .asciz "Error: Command not found!\r\n"
prompt:      .asciz "Louis@MySDOS> "
newline:     .asciz "\r\n"

.section .bss
.balign 16
cmd_buffer: .skip 64
