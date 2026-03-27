.section .text
.global fb_init

/* Kita pakai RAM di alamat 0x41000000 sebagai VRAM (Video RAM) */
/* QEMU Virtio-GPU bakal baca dari sini */

fb_init:
    stp x29, x30, [sp, #-16]!
    
    ldr x0, =0x41000000    /* Alamat Awal VRAM */
    ldr x1, =800000        /* Estimasi jumlah piksel (untuk resolusi standar) */
    ldr x2, =0x00001144    /* Warna Biru Symmetrical (0xRRGGBB) */

clear_vram:
    cbz x1, fb_done
    str w2, [x0], #4       /* Isi 4 byte (1 piksel) lalu geser ke piksel berikutnya */
    sub x1, x1, #1
    b clear_vram

fb_done:
    ldp x29, x30, [sp], #16
    ret
