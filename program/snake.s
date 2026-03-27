.section .text
.global run_snake

run_snake:
    stp x29, x30, [sp, #-48]!
    
    /* Posisi awal */
    mov x19, #5     /* x */
    mov x20, #5     /* y */

game_loop:
    /* 1. Reset Kursor ke pojok (Home) */
    adr x0, cursor_home; bl print_string

    /* 2. Judul Game (Warna Kuning: 33) */
    adr x0, msg_game; mov x1, #33; bl print_color_string

    /* 3. Geser ke bawah (Y) */
    mov x2, x20
print_y:
    cbz x2, print_x
    adr x0, newline; bl print_string
    sub x2, x2, #1
    b print_y

print_x:
    /* 4. Geser ke kanan (X) */
    mov x2, x19
print_spc:
    cbz x2, draw_head
    adr x0, space; bl print_string
    sub x2, x2, #1
    b print_spc

draw_head:
    /* 5. Gambar Kepala Merah (31) */
    mov x0, #31
    bl draw_block
    
    adr x0, newline; bl print_string
    adr x0, newline; bl print_string

    /* 6. DELAY FIXED: Pakai LDR biar gak error */
    ldr x2, =0x2FFFFFF
delay_loop:
    subs x2, x2, #1
    b.ne delay_loop

    /* 7. Update posisi uler */
    add x19, x19, #1
    
    /* Batas layar */
    cmp x19, #30
    b.gt reset_x
    
    b game_loop

reset_x:
    mov x19, #0
    add x20, x20, #1
    cmp x20, #15
    b.gt reset_all
    b game_loop

reset_all:
    mov x19, #5
    mov x20, #5
    b game_loop

.section .data
cursor_home: .asciz "\x1B[H"
space:       .asciz " "
msg_game:    .asciz "--- MyS-Snake: The Terminal Legend ---\r\n"
