.section .text
.global get_char, put_char

/* Baca input dari UART (Keyboard) */
get_char:
    ldr x1, =0x09000000
1:  ldr w2, [x1, #0x18]
    tst w2, #0x10
    b.ne 1b
    ldr w0, [x1]
    ret

/* Cetak karakter ke layar */
put_char:
    ldr x1, =0x09000000
1:  ldr w2, [x1, #0x18]
    tst w2, #0x20
    b.ne 1b
    str w0, [x1]
    ret
