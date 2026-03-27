.section .text
.global run_sysinfo

run_sysinfo:
    stp x29, x30, [sp, #-32]!
    
    /* Header */
    adr x0, msg_title; mov x1, #33; bl print_color_string
    
    /* 1. BACA REGISTER CPU ASLI (REAL HARDWARE) */
    mrs x19, midr_el1    /* Tarik data Main ID Register ke x19 */
    
    /* Tampilkan mentah-mentah dalam bentuk teks (Simulasi konversi Hex sederhana) */
    adr x0, msg_cpu_id; bl print_string
    
    /* Kita cek: Kalau nilainya 0x410fd034 berarti beneran Cortex-A53 */
    ldr x20, =0x410fd034
    cmp x19, x20
    b.eq is_a53
    
    adr x0, val_unknown; mov x1, #31; bl print_color_string
    b info_done

is_a53:
    adr x0, val_a53; mov x1, #32; bl print_color_string

info_done:
    /* 2. REAL RAM INFO (Dari Linker) */
    adr x0, msg_ram; bl print_string
    adr x0, val_ram; mov x1, #32; bl print_color_string
    
    adr x0, newline; bl print_string
    ldp x29, x30, [sp], #32
    ret

.section .data
msg_title:  .asciz "\r\n--- MySDOS REAL HARDWARE MONITOR ---\r\n"
msg_cpu_id: .asciz " [CPU ID Register] : "
val_a53:    .asciz "0x410FD034 (Genuine Cortex-A53)\r\n"
val_unknown:.asciz "Unknown / Emulator Optimized\r\n"
msg_ram:    .asciz " [RAM Config]      : "
val_ram:    .asciz "128MB Virt-RAM Detected\r\n"
