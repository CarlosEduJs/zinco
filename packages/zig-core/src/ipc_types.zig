const std = @import("std");

pub const TriggerJobPayload = struct {
    name: []const u8,
    payload: std.json.Value = .null,
    workflow_id: ?[]const u8 = null,
    request_id: ?[]const u8 = null,
};

pub const JobResultPayload = struct {
    job_id: []const u8,
    status: []const u8,
    result: ?std.json.Value = null,
    @"error": ?std.json.Value = null,
};

pub const LogEntryPayload = struct {
    level: []const u8,
    message: []const u8,
    job_id: ?[]const u8 = null,
    workflow_id: ?[]const u8 = null,
    metadata: ?std.json.Value = null,
};
