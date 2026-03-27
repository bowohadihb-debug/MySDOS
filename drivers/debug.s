.section .text
.balign 8
.global debug_log

debug_log:
    stp x29, x30, [sp, #-16]!
    adr x0, msg_debug_tag
    bl print_string
    ldp x29, x30, [sp], #16
    ret

.section .data
.balign 8
msg_debug_tag: .asciz "[DEBUG] CPU Checkpoint Reached\r\n"
