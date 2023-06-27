const tty = @import("tty.zig");

export fn kmain() noreturn {
    // This works
    // var buffer = @intToPtr([*]volatile u16, 0xb8000);
    // buffer[0] = 0x0221;
    tty.clear();
    tty.putStr("Hello world!");

    while (true) {}
}
