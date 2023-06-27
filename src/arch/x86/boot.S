// multiboot setup
.set MAGIC,    0x1BADB002
.set ALIGN,    1<<0 // align loaded modules on page boundaries
.set MEMINFO,  1<<1 // provide memory map
.set FLAGS,    ALIGN | MEMINFO
.set CHECKSUM, -(MAGIC + FLAGS)

// multiboot structure
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

// stack
.section .bss
.align 16
stack_bottom:
.skip 1024 * 16 // 16 KiB
stack_top:

// entry point
.section .text
.global _start
.type _start, @function
_start:
    // set the stack
	mov $stack_top, %esp

    // start kernel
	call kmain

    // stop the cpu
    cli
    hlt
