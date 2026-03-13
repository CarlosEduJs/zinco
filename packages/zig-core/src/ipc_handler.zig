const std = @import("std");
const protocol = @import("ipc_protocol.zig");

pub const Handler = struct {
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) Handler {
        return Handler{ .allocator = allocator };
    }

    pub fn handleConnection(self: *Handler, connection: std.net.StreamServer.Connection) !void {
        defer connection.stream.close();
        const reader = connection.stream.reader();
        const writer = connection.stream.writer();

        while (true) {
            const header = protocol.readHeader(reader) catch |err| {
                if (err == error.EndOfStream) return;
                return err;
            };

            if (header.payload_len > protocol.MaxPayloadSize) {
                return error.PayloadTooLarge;
            }

            const payload = try self.allocator.alloc(u8, header.payload_len);
            defer self.allocator.free(payload);
            if (header.payload_len > 0) {
                try reader.readNoEof(payload);
            }

            const message_type = @as(protocol.MessageType, @enumFromInt(header.message_type));
            switch (message_type) {
                .ping => try self.sendAck(writer),
                .trigger_job => try self.sendAck(writer),
                .job_result => try self.sendAck(writer),
                .log_entry => try self.sendAck(writer),
                .ack => {},
                else => return error.UnknownMessageType,
            }
        }
    }

    fn sendAck(_: *Handler, writer: anytype) !void {
        const header = protocol.Header{
            .message_type = @intFromEnum(protocol.MessageType.ack),
            .reserved = 0,
            .payload_len = 0,
        };
        try protocol.writeHeader(writer, header);
    }
};
