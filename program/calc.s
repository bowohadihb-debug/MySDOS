.section .text
.global run_calc
run_calc:
    stp x29, x30, [sp, #-16]!
    adr x0, msg_c; bl print_string
    ldp x29, x30, [sp], #16
    ret
.section .data
msg_c: .asciz "\r\n[MyS] Encryption Machine Active.\r\n"
