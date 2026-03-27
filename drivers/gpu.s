.section .text
.global draw_block, draw_rect

draw_block:
    stp x29, x30, [sp, #-16]!
    mov x19, x0
    
    /* Cetak ESC [ <warna> m */
    mov w0, #0x1B; bl put_char  /* Pakai Hex 0x1B biar mantap */
    mov w0, #'['; bl put_char
    
    /* Handle kode warna (Cuma 31 atau 32) */
    mov x1, #10
    udiv x2, x19, x1
    msub x3, x2, x1, x19
    add w0, w2, #'0'; bl put_char
    add w0, w3, #'0'; bl put_char
    mov w0, #'m'; bl put_char

    /* Gambar balok */
    adr x0, block_char; bl print_string
    ldp x29, x30, [sp], #16
    ret

draw_rect:
    stp x29, x30, [sp, #-48]!
    mov x19, x2    /* lebar */
    mov x20, x3    /* tinggi */
    mov x21, x4    /* warna */

row_loop:
    cbz x20, rect_done
    mov x22, x19
col_loop:
    cbz x22, next_row
    mov x0, x21
    bl draw_block
    sub x22, x22, #1
    b col_loop
next_row:
    /* RESET WARNA ke Putih (0) di akhir baris */
    mov w0, #0x1B; bl put_char
    mov w0, #'['; bl put_char
    mov w0, #'0'; bl put_char
    mov w0, #'m'; bl put_char
    
    adr x0, newline; bl print_string
    sub x20, x20, #1
    b row_loop
rect_done:
    ldp x29, x30, [sp], #48
    ret

.section .data
block_char: .asciz "█"
