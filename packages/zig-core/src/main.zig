const std = @import("std");
const Server = @import("server.zig").Server;
const Config = @import("config.zig").Config;

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
