.section .text
.global gpio_set_direction
.global gpio_write_bit

/* Alamat GPIO QEMU Virt (Cek spesifikasi virt board) */
.equ GPIO_BASE, 0x09030000 

/* x0 = pin number, x1 = direction (0=in, 1=out) */
gpio_set_direction:
    ldr x2, =GPIO_BASE
    ldr w3, [x2, #0x0]      /* Baca register arah (Direction Reg) */
    
    cbz x1, 1f              /* Jika x1 == 0 (Input) */
    orr w3, w3, #1          /* Set bit (Output) - Simplifikasi buat pin 0 */
    b 2f
1:  bic w3, w3, #1          /* Clear bit (Input) */
2:  str w3, [x2, #0x0]      /* Tulis balik */
    ret

/* x0 = pin number, x1 = value (0 atau 1) */
gpio_write_bit:
    ldr x2, =GPIO_BASE
    cbz x1, 3f              /* Jika x1 == 0, lari ke Off */
    mov w3, #1
    str w3, [x2, #0x4]      /* Tulis ke Data Register */
    ret
3:  mov w3, #0
    str w3, [x2, #0x4]
    ret
