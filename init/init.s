.section .text
.global run_init

run_init:
    stp x29, x30, [sp, #-16]!

    /* 1. Header Init (Warna Kuning: 33) */
    adr x0, msg_init_start; mov x1, #33; bl print_color_string

    /* 2. Cek CPU */
    adr x0, msg_cpu; bl print_string
    bl fake_delay
    adr x0, msg_ok; mov x1, #32; bl print_color_string

    /* 3. Cek Memory */
    adr x0, msg_mem; bl print_string
    bl fake_delay
    adr x0, msg_ok; mov x1, #32; bl print_color_string

    /* 4. Mount MyS-FS */
    adr x0, msg_fs; bl print_string
    bl fake_delay
    adr x0, msg_ok; mov x1, #32; bl print_color_string

    adr x0, msg_done; mov x1, #36; bl print_color_string
    
    ldp x29, x30, [sp], #16
    ret

/* Delay sederhana biar loadingnya kerasa */
fake_delay:
    mov x2, #0x1FFFFFF
1:  subs x2, x2, #1
    b.ne 1b
    ret

.section .data
msg_init_start: .asciz ">>> MySDOS System Initialization <<<\r\n"
msg_cpu:        .asciz "[*] Checking CPU AArch64...          "
msg_mem:        .asciz "[*] Allocating 128MB RAM...          "
msg_fs:         .asciz "[*] Mounting MyS-FS Driver...        "
msg_ok:         .asciz "[ OK ]\r\n"
msg_done:       .asciz ">>> Initialization Complete! <<<\r\n\r\n"
