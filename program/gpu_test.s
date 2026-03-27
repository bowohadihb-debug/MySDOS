.section .text
.global run_gpu_test

run_gpu_test:
    stp x29, x30, [sp, #-16]!
    
    adr x0, msg_gpu_test; mov x1, #35; bl print_color_string
    
    /* Gambar Kotak Merah (31) ukuran 10x3 */
    mov x2, #10
    mov x3, #3
    mov x4, #31
    bl draw_rect

    /* Gambar Kotak Hijau (32) ukuran 20x2 */
    mov x2, #20
    mov x3, #2
    mov x4, #32
    bl draw_rect

    ldp x29, x30, [sp], #16
    ret

.section .data
msg_gpu_test: .asciz "\r\n--- MyS Terminal GPU Benchmark ---\r\n"
