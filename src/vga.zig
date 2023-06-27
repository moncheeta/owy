const std = @import("std");

pub const WIDTH = 80;
pub const HEIGHT = 25;
pub const SIZE = WIDTH * HEIGHT;

pub const Color = enum(u4) {
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    LightMagenta = 13,
    Yellow = 14,
    White = 15,
};

pub const Cell = packed struct {
    character: u8,
    foreground: Color,
    background: Color,
};

pub fn createCell(character: u8, foreground: Color, background: Color) Cell {
    return Cell{ .character = character, .foreground = foreground, .background = background };
}

var buffer = @intToPtr([*]volatile Cell, 0xb8000);

pub fn putCellAt(cell: Cell, column: usize, row: usize) void {
    const index = (row * WIDTH) + column;
    buffer[index] = cell;
}

pub fn clear() void {
    const BLANK = createCell(' ', Color.White, Color.Black);
    var index: usize = 0;
    while (index < SIZE) : (index += 1) {
        buffer[index] = BLANK;
    }
}
