.section .text
.global sleep_ms

sleep_ms:
    /* x0 = milidetik. Loop kasar buat nunggu */
    mov x1, #0x5000         /* Konstanta loop (sesuaikan speed QEMU) */
    mul x0, x0, x1
1:  subs x0, x0, #1
    b.ne 1b
    ret
