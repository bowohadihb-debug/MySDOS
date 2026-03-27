.section .text
.global run_gui_test

run_gui_test:
    stp x29, x30, [sp, #-16]!
    
    bl clear_screen
    
    /* Gambar Window Utama */
    mov x0, #30             /* Width */
    mov x1, #5              /* Height */
    adr x2, title_text      /* Title */
    bl draw_window
    
    adr x0, msg_gui; bl print_string
    
    ldp x29, x30, [sp], #16
    ret

.section .data
title_text: .asciz " MySDOS GUI v1.0 "
msg_gui:    .asciz "\n [Press any key to exit GUI mode]\n"
