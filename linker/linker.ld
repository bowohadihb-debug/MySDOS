ENTRY(_start)
SECTIONS
{
    . = 0x40100000;
    
    .text : { 
        *(.text.boot)   /* Prioritas: Booting */
        *(.text)        /* Kode Kernel Utama */
        *(.text*)       /* INI KUNCINYA: Biar semua fungsi tambahan masuk! */
    }
    
    .data : { 
        *(.data) 
        *(.data*)       /* Pastikan string "MySDOS>" juga masuk */
    }
    
    .bss : {
        . = ALIGN(16);
        *(.bss)
        *(COMMON)
    }
    
    . = ALIGN(8);
    _stack_top = . + 0x10000;
}
