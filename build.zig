const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cppz_dep = b.dependency("cpp", .{ .target = target, .optimize = optimize });

    const lib = b.addStaticLibrary(.{
        .name = "cppz",
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(cppz_dep.path("."));
    lib.addCSourceFile(.{
        .file = cppz_dep.path("main.cpp"),
        .flags = &.{
            "-std=c++11",
        },
    });

    lib.linkLibCpp();

    _ = b.addModule("cppz", .{
        .root_source_file = b.path("src/main.zig"),
    });

    b.installArtifact(lib);
}
