// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library for
// using this as a script.
const std = @import("std");

// The main function to invoke any
// build routines.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const xian = b.dependency("xian", .{});
    const xian_mod = xian.module("xian");
    const mod = b.addModule(
        "ziply",
        .{
            .root_source_file = b.path("./src/root.zig"),
            .target = target,
            .optimize = optimize
        }
    );
    mod.addImport("xian", xian_mod);
    const lib = b.addLibrary(
        .{
            .linkage = .static,
            .name = "ziply",
            .root_module = mod
        }
    );
    b.installArtifact(lib);
    const test_mod = b.createModule(
        .{
            .root_source_file = b.path("./src/tests.zig"),
            .target = target,
            .optimize = optimize,
        }
    );
    test_mod.addImport("xian", xian_mod);
    const lib_test = b.addTest(
        .{
            .root_module = test_mod,
        }
    );
    const test_step = b.step("test", "Run library tests.");
    test_step.dependOn(&lib_test.step);
}
