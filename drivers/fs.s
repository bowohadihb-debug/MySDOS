.section .data
.align 3
.global mys_fs_start

mys_fs_start:
    /* File 1: Kernel */
    .asciz "kernel.s    "       /* Nama File (Padding spasi biar rapi) */
    .quad file_1_data           /* Alamat Isi */
    
    /* File 2: Setup */
    .asciz "setup.bin   "
    .quad file_2_data
    
    /* File 3: Martabak (Pesanan Dumai) */
    .asciz "martabak.txt"
    .quad file_3_data
    
    .quad 0                     /* Penanda Akhir FS (Null) */

/* ISI FILE ASLI */
file_1_data: .asciz "MyS Kernel v.0.0.0.1 Source Code..."
file_2_data: .asciz "Setup Wizard Binary Data [010101]"
file_3_data: .asciz "Status Martabak: Sedang dibuat oleh koki MySDOS."
