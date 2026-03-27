.section .text
.global _start

_start:
    /* Set Stack Pointer ke alamat aman (High Memory) */
    ldr x0, =0x40080000
    mov sp, x0

    /* Reset Register Penting agar tidak ada 'Sampah' */
    mov x19, #0
    mov x20, #0
    mov x21, #0

    /* Lompat ke Main Kernel */
    bl kernel_main

    /* Jika kernel exit (halt) */
1:  wfe
    b 1b
