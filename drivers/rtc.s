.section .text
.balign 8
.global rtc_init

rtc_init:
    /* RTC biasanya cuma baca register, tapi tetap kasih 'ret' yang bersih */
    mrs x0, cntfrq_el0
    mrs x1, cntvct_el0
    ret
