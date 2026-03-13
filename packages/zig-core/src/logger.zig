const std = @import("std");

pub fn logFn(
    comptime level: std.log.Level,
    comptime scope: @Type(.EnumLiteral),
    comptime format: []const u8,
    args: anytype,
) void {
    var msg_buf: [1024]u8 = undefined;
    const msg = std.fmt.bufPrint(&msg_buf, format, args) catch "log message truncated";

    var out = std.io.getStdErr().writer();
    const level_str = @tagName(level);
    const scope_str = @tagName(scope);
    const ts_ms = std.time.milliTimestamp();

    const payload = LogPayload{
        .ts_ms = ts_ms,
        .level = level_str,
        .scope = scope_str,
        .message = msg,
    };

    std.json.stringify(payload, .{}, out) catch return;
    out.writeByte('\n') catch return;
}

const LogPayload = struct {
    ts_ms: i64,
    level: []const u8,
    scope: []const u8,
    message: []const u8,
};
