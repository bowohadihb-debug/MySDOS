.section .text
.global kernel_panic

kernel_panic:
    mov x19, x0
    adr x0, panic_header; bl print_string
    mov x0, x19; bl print_string
    adr x0, panic_footer; bl print_string

panic_halt:
    wfi
    b panic_halt

.section .data
panic_header: .asciz "\r\n[!!!] KERNEL PANIC [!!!]\r\nERROR: "
panic_footer: .asciz "\r\nSystem Halted.\r\n"
