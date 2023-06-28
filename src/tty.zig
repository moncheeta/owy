const std = @import("std");
const vga = @import("video/vga.zig");

var column: usize = 0;
var row: usize = 0;

var foreground: vga.Color = vga.Color.White;
var background: vga.Color = vga.Color.Black;

fn nextColumn() void {
    if (column > vga.WIDTH) {
        nextRow();
        return;
    }
    column += 1;
}

fn nextRow() void {
    column = 0;
    row += 1;
    if (row > vga.HEIGHT) {
        // temp
        // should move all the text up
        column = 0;
        row = 0;
        return;
    }
}

fn putChar(character: u8) void {
    if (character == '\r') {
        column = 0;
        return;
    } else if (character == '\n') {
        nextRow();
        return;
    }
    const cell = vga.Cell.create(character, foreground, background);
    vga.putCellAt(cell, column, row);
    nextColumn();
}

fn putStr(string: []const u8) void {
    for (string) |character| {
        putChar(character);
    }
}

pub const writer = std.io.Writer(void, error{}, callback){ .context = {} };
fn callback(_: void, string: []const u8) error{}!usize {
    putStr(string);
    return string.len;
}

pub fn init() void {
    vga.clear();
    vga.disableCursor();
}
