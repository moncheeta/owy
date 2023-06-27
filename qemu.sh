#!/bin/sh
# emulates the kernel with qemu
KERNEL_PATH=$1
qemu-system-i386 \
    -kernel $KERNEL_PATH
    -debugcon stdio \
    -vga virtio \
    -m 4G
