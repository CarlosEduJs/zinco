const std = @import("std");

pub const Config = struct {
    socket_path: []u8,

    pub fn load(allocator: std.mem.Allocator) !Config {
        const env = std.process.getEnvMap(allocator) catch null;
        defer if (env) |map| map.deinit();

        const default_path = "/tmp/zinco-core.sock";
        var socket_value: []const u8 = default_path;
        if (env) |map| {
            if (map.get("ZINCO_SOCKET")) |value| {
                socket_value = value;
            }
        }

        const socket_path = try allocator.dupe(u8, socket_value);
        return Config{ .socket_path = socket_path };
    }

    pub fn deinit(self: *Config, allocator: std.mem.Allocator) void {
        allocator.free(self.socket_path);
    }
};
