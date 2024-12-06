const std = @import("std");
const Buffer = @import("Buffer.zig");

buffer: Buffer,
pos: usize,

const Self = @This();

pub fn readUntilDelimiter(self: *Self, delimiter: u8) ![]const u8 {
    const idx = std.mem.indexOfScalar(u8, self.buffer.bytes[self.pos..], delimiter) + 1;
    defer self.pos = idx;

    return self.buffer.bytes[self.pos..idx];
}

pub fn readInt(self: *Self, comptime T: type) T {
    defer self.pos += @sizeOf(T);

    return std.mem.bigToNative(T, std.mem.bytesAsValue(T, self.buffer.bytes[self.pos..@sizeOf(T)]).*);
}