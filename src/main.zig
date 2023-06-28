const std = @import("std");
const tty = @import("tty.zig");

export fn kmain() noreturn {
    tty.init();
    try tty.writer.print("It works!\n", .{});
    try tty.writer.print("Hello World!", .{});
    while (true) {}
}
