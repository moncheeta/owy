const std = @import("std");
const text = @import("video/text.zig");
const vga = @import("video/vga.zig");

var column: usize = 0;
var row: usize = 0;

var foreground: text.Color = text.Color.White;
var background: text.Color = text.Color.Black;

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
    const cell = text.Cell.create(character, foreground, background);
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
    vga.moveCursor(column, row);
    return string.len;
}

pub fn init() void {
    vga.clear(background);
    vga.disableCursor();
    vga.enableCursor();
}
