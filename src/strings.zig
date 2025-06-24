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

/// This function returns
/// the length of a string
/// with a null-terminator
/// as an unsigned integer.
pub fn str_len(
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
pub const String = struct {
    items: ArrayList(u8),
    allocator: std.mem.Allocator,

    /// Instantiates this
    /// structure with
    /// an allocator
    /// and a pointer to
    /// a string.
    pub fn init(
        subject: [*:0]const u8,
        allocator: std.mem.Allocator
    ) !String {
        const len: usize = str_len(subject);
        var char_list: ArrayList(u8) = ArrayList(u8)
            .init(allocator);
        defer char_list.deinit();
        for (0..len) |i| {
            try char_list.append(subject[i]);
        }
        return String{
            .items = char_list
        };
    }

    /// A function to free the resources
    /// taken by the internal `ArrayLis`.
    pub fn deinit(self: *String) void {
        self.items.deinit();
    }
};
