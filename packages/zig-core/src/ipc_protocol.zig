const std = @import("std");

pub const MessageType = enum(u16) {
    ping = 1,
    ack = 2,
    trigger_job = 10,
    job_result = 11,
    log_entry = 12,
};

pub const Header = packed struct {
    message_type: u16,
    reserved: u16,
    payload_len: u32,
};

pub const MaxPayloadSize: usize = 1024 * 256;

pub fn readHeader(reader: anytype) !Header {
    var header_bytes: [@sizeOf(Header)]u8 = undefined;
    try reader.readNoEof(&header_bytes);
    return headerFromBytes(&header_bytes);
}

pub fn writeHeader(writer: anytype, header: Header) !void {
    var header_bytes: [@sizeOf(Header)]u8 = undefined;
    std.mem.writeInt(u16, header_bytes[0..2], header.message_type, .little);
    std.mem.writeInt(u16, header_bytes[2..4], header.reserved, .little);
    std.mem.writeInt(u32, header_bytes[4..8], header.payload_len, .little);
    try writer.writeAll(&header_bytes);
}

pub fn headerFromBytes(bytes: []const u8) Header {
    return Header{
        .message_type = std.mem.readInt(u16, bytes[0..2], .little),
        .reserved = std.mem.readInt(u16, bytes[2..4], .little),
        .payload_len = std.mem.readInt(u32, bytes[4..8], .little),
    };
}
