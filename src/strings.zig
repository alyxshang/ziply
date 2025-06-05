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

// Importing one of
// the standard allocator.
const allocator = std.heap.page_allocator;

/// This function returns
/// the length of a string
/// with a null-terminator
/// as an unsigned integer.
pub export fn str_len(
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

/// A structure to store
/// a growable string.
/// An array of `u8`s
/// is stored in a growable
/// array.
const String = struct {
    items: ArrayList(u8),

    /// Instantiates this
    /// structure with
    /// an allocator
    /// and a pointer to
    /// a string.
    pub export fn init(
        subject: [*:0]const u8,
        allocator: allocator
    ) !String {
        const len: usize = str_len(
        var char_list: ArrayList(u8)
            .init(allocator);
        defer
        for (0..len) |i| {
            try char_list.append(subject[i]);
        }
        return String{
            .items = char_list
        };
    }
};
