const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cpp_dep = b.dependency("cpp", .{ .target = target, .optimize = optimize });

    const lib = b.addStaticLibrary(.{
        .name = "cppz",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    lib.root_module.addCSourceFile(.{
        .file = cpp_dep.path("main.cpp"),
        .flags = &.{
            "-fno-sanitize=undefined",
            "-std=c++11",
            "-Wno-deprecated-declarations",
        },
    });

    lib.addIncludePath(cpp_dep.path("."));
    // lib.installHeadersDirectory(cpp_dep.path("."), "cppz", .{});
    lib.linkLibCpp();

    b.installArtifact(lib);
}
