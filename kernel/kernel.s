.section .text
.global kernel_main

kernel_main:
    bl run_init
    bl run_ver

shell_loop:
    /* Prompt MySDOS */
    adr x0, prompt; mov x1, #34; bl print_color_string
    
    /* Input Keyboard */
    bl get_char
    and w19, w0, #0xFF
    
    /* Echo & Newline */
    mov w0, w19; bl put_char
    adr x0, newline; bl print_string

    /* --- LOGIKA COMMAND v.0.0.0.6 --- */
    
    /* v = Info Versi */
    cmp w19, #'v'
    b.eq call_ver
    
    /* i = REAL SYSTEM INFO (NEW!) */
    cmp w19, #'i'
    b.eq call_sysinfo
    
    /* s = Snake Game */
    cmp w19, #'s'
    b.eq call_snake
    
    /* g = GPU Test */
    cmp w19, #'g'
    b.eq call_gpu_test
    
    /* p = Trigger Panic */
    cmp w19, #'p'
    b.eq trigger_panic

    b shell_loop

/* --- HANDLER JUMP --- */

call_sysinfo:
    bl run_sysinfo   /* Memanggil driver hardware monitor */
    b shell_loop

call_ver:
    bl run_ver
    b shell_loop

call_snake:
    bl run_snake
    b shell_loop

call_gpu_test:
    bl run_gpu_test
    b shell_loop

trigger_panic:
    adr x0, msg_panic; bl kernel_panic
    b shell_loop

.section .data
.align 3
prompt:    .asciz "MySDOS[HW-MON]> "
msg_panic: .asciz "MANUAL_KERNEL_HALT_REQUESTED"
