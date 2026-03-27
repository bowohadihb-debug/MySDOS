.section .text
.global run_setup

run_setup:
    stp x29, x30, [sp, #-16]!
    
    /* Cetak pesan yang GEDE biar kelihatan */
    adr x0, msg_wizard; bl print_string
    
    ldp x29, x30, [sp], #16
    ret

.section .data
.align 3
msg_wizard: .asciz "\r\n[ SYSTEM ] === STARTING MYSDOS SETUP WIZARD ===\r\n"
