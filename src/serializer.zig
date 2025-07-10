// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library.
const std = @import("std");

// Importing a string library.
const xian = @import("xian");

// Importing the data structure
// to handle errors.
const err = @import("err.zig");

// Importing the "ArrayList"
// data structure from the
// standard library because
// lists will be needed.
const ArrayList = std.ArrayList;

/// Serializes the app's CLI
/// arguments into a list of
/// strings. If this operation
/// fails, an error is returned.
pub fn serializeArgs(
    iterator: std.process.ArgIterator,
    allocator: std.mem.Allocator
) !ArrayList(xian.String) {
    var arr = ArrayList(xian.String)
        .init(allocator);
    while (iterator.next()) |item| {
        var new_str = xian
            .String
            .init(item);
        arr.append(new_str)
            return err.ZiplyErr.WriteErr;
    }
    return arr;
}
