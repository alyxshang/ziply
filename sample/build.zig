const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe_mod = b.createModule(
        .{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }
    );
    const ziply = b.dependency("ziply", .{});
    const ziply_mod = ziply.module("ziply");
    exe_mod.addImport("ziply", ziply_mod);
    const exe = b.addExecutable(
        .{
            .name = "sample",
            .root_module = exe_mod,
        }
    );
    b.installArtifact(exe);
}
