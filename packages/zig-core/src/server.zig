const std = @import("std");
const UdsServer = @import("uds.zig").UdsServer;
const Handler = @import("ipc_handler.zig").Handler;
const Config = @import("config.zig").Config;

pub const Server = struct {
    allocator: std.mem.Allocator,
    uds: UdsServer,
    handler: Handler,
    socket_path: []const u8,

    pub fn init(allocator: std.mem.Allocator, config: Config) !Server {
        std.fs.deleteFileAbsolute(config.socket_path) catch |err| {
            if (err != error.FileNotFound) return err;
        };
        const uds = try UdsServer.init(config.socket_path);
        return Server{
            .allocator = allocator,
            .uds = uds,
            .handler = Handler.init(allocator),
            .socket_path = config.socket_path,
        };
    }

    pub fn deinit(self: *Server) void {
        self.uds.deinit();
    }

    pub fn run(self: *Server) !void {
        while (true) {
            const connection = try self.uds.accept();
            std.log.info("ipc connection accepted", .{});
            self.handler.handleConnection(connection) catch |err| {
                std.log.err("connection error: {s}", .{@errorName(err)});
            };
        }
    }
};
