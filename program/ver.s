.section .text
.global run_ver

run_ver:
    stp x29, x30, [sp, #-16]!
    
    /* 1. Cetak Logo (Warna Cyan: 36) */
    adr x0, ver_logo; mov x1, #36; bl print_color_string
    
    /* 2. Cetak Info Detail (Warna Putih: 37) */
    adr x0, ver_info; mov x1, #37; bl print_color_string
    
    ldp x29, x30, [sp], #16
    ret

.section .data
.align 3
ver_logo:
    .asciz "\r\n  __  __       _____ _____   ____   _____\r\n |  \\/  |     / ____|  __ \\ / __ \\ / ____|\r\n | \\  / |_   _| (___ | |  | | |  | | (___ \r\n | |\\/| | | | |\\___ \\| |  | | |  | |\\___ \\\r\n | |  | | |_| |____) | |__| | |__| |____) |\r\n |_|  |_|\\__, |_____/|_____/ \\____/|_____/ \r\n          __/ |                            \r\n         |___/                             \r\n"

ver_info:
    .asciz " OS Name:   MySDOS\r\n Version:   0.0.0.3\r\n Build:     2026-03-27\r\n Arch:      AArch64 (ARMv8-A)\r\n Developer: Louis Gavriel\r\n Status:    Development (Pre-Alpha)\r\n\r\n"
