.section .text
.balign 8
.global disk_init

disk_init:
    ldr x1, =0x0a000000    /* Alamat Dasar VirtIO Disk */
    ldr w2, [x1]           /* Baca Magic Value (Harus "virt") */
    ldr w3, =0x74726976    /* Hex untuk "virt" */
    cmp w2, w3
    bne disk_fail
    ret
disk_fail:
    /* Jika gagal, kita bisa loop selamanya atau lapor error */
    ret
