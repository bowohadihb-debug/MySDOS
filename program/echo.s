.section .text
.global run_echo

run_echo:
    stp x29, x30, [sp, #-16]!
    
    /* x20 adalah alamat cmd_buffer dari kernel */
    /* Kita mulai cetak dari index ke-2 (setelah 'e ') */
    add x0, x20, #2
    ldrb w1, [x0]
    cbz w1, no_args
    
    bl  print_string
    b   echo_done

no_args:
    adr x0, msg_echo_empty
    bl  print_string

echo_done:
    adr x0, newline
    bl  print_string
    ldp x29, x30, [sp], #16
    ret

.section .data
msg_echo_empty: .asciz "Usage: e [text]"
