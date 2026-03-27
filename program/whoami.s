.section .text
.global run_whoami

run_whoami:
    stp x29, x30, [sp, #-16]!
    adr x0, info_box; bl print_string
    /* Tambah newline di akhir biar prompt gak nempel */
    adr x0, newline;  bl print_string 
    ldp x29, x30, [sp], #16
    ret

.section .data
.align 3
info_box: 
    .asciz "+-----------------------+\r\n|    LOUIS G. HADISON   |\r\n+-----------------------+\r\n"
