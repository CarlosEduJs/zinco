const std = @import("std");
const protocol = @import("ipc_protocol.zig");
const types = @import("ipc_types.zig");

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
                .trigger_job => try self.handleTriggerJob(payload, writer),
                .job_result => try self.handleJobResult(payload, writer),
                .log_entry => try self.handleLogEntry(payload, writer),
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

    fn handleTriggerJob(self: *Handler, payload: []const u8, writer: anytype) !void {
        try parseJsonPayload(types.TriggerJobPayload, self.allocator, payload);
        std.log.info("ipc trigger_job received", .{});
        try self.sendAck(writer);
    }

    fn handleJobResult(self: *Handler, payload: []const u8, writer: anytype) !void {
        try parseJsonPayload(types.JobResultPayload, self.allocator, payload);
        std.log.info("ipc job_result received", .{});
        try self.sendAck(writer);
    }

    fn handleLogEntry(self: *Handler, payload: []const u8, writer: anytype) !void {
        try parseJsonPayload(types.LogEntryPayload, self.allocator, payload);
        std.log.info("ipc log_entry received", .{});
        try self.sendAck(writer);
    }
};

fn parseJsonPayload(comptime T: type, allocator: std.mem.Allocator, payload: []const u8) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var parsed = try std.json.parseFromSlice(T, arena.allocator(), payload, .{
        .allocate = .alloc_if_needed,
        .ignore_unknown_fields = true,
    });
    defer parsed.deinit();
}
