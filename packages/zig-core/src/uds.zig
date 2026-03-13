const std = @import("std");

pub const UdsServer = struct {
    listener: std.net.StreamServer,
    socket_path: []const u8,

    pub fn init(socket_path: []const u8) !UdsServer {
        var server = std.net.StreamServer.init(.{ .reuse_address = true });
        const address = try std.net.Address.initUnix(socket_path);
        try server.listen(address);
        return UdsServer{ .listener = server, .socket_path = socket_path };
    }

    pub fn deinit(self: *UdsServer) void {
        self.listener.deinit();
    }

    pub fn accept(self: *UdsServer) !std.net.StreamServer.Connection {
        return self.listener.accept();
    }
};
