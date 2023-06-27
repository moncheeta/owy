const std = @import("std");
const vga = @import("vga.zig");

var column: usize = 0;
var row: usize = 0;

var foreground: vga.Color = vga.Color.White;
var background: vga.Color = vga.Color.Black;

pub fn putChar(character: u8) void {
    const cell = vga.createCell(character, foreground, background);
    vga.putCellAt(cell, column, row);
    if (column == vga.WIDTH) {
        if (row == vga.HEIGHT) {
            row = 0;
            return;
        }
        row += 1;
        return;
    }
    column += 1;
}

pub fn putStr(string: []const u8) void {
    for (string) |character| {
        putChar(character);
    }
}

pub fn clear() void {
    vga.clear();
}

// pub const writer = std.io.Writer(void, error{}, callback){ .context = {} };
// fn callback(_: void, string: []const u8) error{}!usize {
//     putStr(string);
//     return string.len;
// }
