const std = @import("std");
const logger = @import("logger.zig");
const Server = @import("server.zig").Server;
const Config = @import("config.zig").Config;

pub const std_options = struct {
    pub const log_level = std.log.Level.info;
    pub const logFn = logger.logFn;
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) {
            std.log.err("memory leak detected", .{});
        }
    }
    const allocator = gpa.allocator();

    var config = try Config.load(allocator);
    defer config.deinit(allocator);

    var server = try Server.init(allocator, config);
    defer server.deinit();

    std.log.info("zinco-core listening on {s}", .{server.socket_path});
    try server.run();
}
