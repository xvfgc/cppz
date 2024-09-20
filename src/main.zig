const std = @import("std");

extern fn add(a: c_int, b: c_int) c_int;

pub fn zadd(a: i32, b: i32) i32 {
    return add(a, b);
}
