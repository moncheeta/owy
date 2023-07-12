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

    pub fn create(character: u8, foreground: Color, background: Color) Cell {
        return Cell{ .character = character, .foreground = foreground, .background = background };
    }
};
