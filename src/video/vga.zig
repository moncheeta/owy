const io = @import("../arch/x86/io.zig");
const Cell = @import("text.zig").Cell;
const Color = @import("text.zig").Color;

pub const WIDTH = 80;
pub const HEIGHT = 25;
pub const SIZE = WIDTH * HEIGHT;

var buffer = @intToPtr([*]volatile Cell, 0xb8000);

fn getIndex(column: usize, row: usize) usize {
    return (row * WIDTH) + column;
}

pub fn putCellAt(cell: Cell, column: usize, row: usize) void {
    buffer[getIndex(column, row)] = cell;
}

pub fn enableCursor() void {
    io.outb(0x3D4, 0x0A);
    io.outb(0x3D5, 0x00);
}

pub fn disableCursor() void {
    io.outb(0x3D4, 0x0A);
    io.outb(0x3D5, 0x20);
}

pub fn moveCursor(column: usize, row: usize) void {
    const index = @truncate(u16, getIndex(column, row));
    io.outb(0x3D4, 0x0F);
    io.outb(0x3D5, @truncate(u8, (index & 0xFF)));
    io.outb(0x3D4, 0x0E);
    io.outb(0x3D5, @truncate(u8, ((index >> 8) & 0xFF)));
}

pub fn clear(background: Color) void {
    const EMPTY = Cell.create(' ', Color.White, background);
    var index: usize = 0;
    while (index < SIZE) : (index += 1) {
        buffer[index] = EMPTY;
    }
}
