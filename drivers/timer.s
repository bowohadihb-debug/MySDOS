.section .text
.global delay
delay:
1:  subs x0, x0, #1
    bne  1b
    ret
