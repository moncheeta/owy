ENTRY(_start)

SECTIONS {
    /* start at 1M */
    . = 1M;

    /* multiboot header */
    .text : ALIGN(4K) {
        *(.multiboot)
        *(.text)
    }

    /* read-only data */
    .rodata : ALIGN(4K) {
        *(.rodata)
    }

    /* initialized read and write data */
    .data : ALIGN(4K) {
        *(.data)
    }

    /* uninitialized read and write data */
    .bss : ALIGN(4K) {
        *(COMMON)
        *(.bss)
    }
}
