// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library.
const std = @import("std");

// Importing the standard
// `ArrayList` structure.
const ArrayList = std.ArrayList;

// Importing the error type for
// this library.
const errors = @import("err.zig");

/// A function to join a string into a growable
/// array of `u8`s. If this operation is succesful,
/// a `String` object is returned. If this operation
/// fails, an error is returned.
pub fn joinChars(
    joiner: u8,
    subject: ArrayList(u8),
    allocator: std.mem.Allocator
) !string.String {
    var res = ArrayList(string.String)
        .init(allocator);
    for (subject.items) |item|{
        try res.append(joiner);
        try res.append(item);
    }
    return res;
}

/// This function returns
/// the length of a string
/// with a null-terminator
/// as an unsigned integer.
pub fn strLen(
    subject: [*:0]const u8
) usize {
    var len: usize = 0;
    var copy = subject;
    while (copy[0] != 0) {
        len += 1;
        copy += 1;
    }
    return len;
}

pub fn arrayFromArgs(
    allocator: std.mem.Allocator,
    iterator: std.process.ArgIterator
) !ArrayList(string.String) {
    var result: ArrayList(String) = ArrayList(string.String)
        .init(allocator);
    for (iterator) |arg|{
        var list = try std.ArrayList(u8).initCapacity(allocator, arg.len);
        list.appendSlice(arg)
            catch return err.ZiplyErr.AllocationErr;
        const str: String = string.String.fromArray(list);
        result.append(str)
            catch return err.ZiplyErr.AllocationErr;
    }
    return result;
}
