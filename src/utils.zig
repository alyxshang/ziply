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

// Importing the module to handle
// strings.
const string = @import("strings.zig");

// Importing one of the standard library
// allocators.
const allocator = std.heap.page_allocator;

/// A function to join a string into a growable
/// array of `u8`s. If this operation is succesful,
/// a `String` object is returned. If this operation
/// fails, an error is returned.
pub export fn join_chars(
    joiner: u8,
    subject: ArrayList(u8) 
) String {
    var res = ArrayList(String)
        .init(allocator);
    for (subject.items, 0..) |item, i|{
        try res.append(joiner);
        try res.append(item);
    }
    return result;
}

/// A function to split a string by a certain
/// character, this character is a `u8`. If the 
/// operation is successful, a growable array is
/// returned. If the operation fails, an error is 
/// returned.
pub export fn split_string(
    splitter: u8,
    subject: [*:0]const u8
) ArrayList(String) {
    var str_list = ArrayList(String)
        .init(allocator);
    const len = string.str_len(subject);
    var container = ArrayList(u8)
        .init(allocator);
    for (0..len) |i| {
        const curr: u8 = subject[i];
        if (curr == splitter){
            try str_list.append(
                join_chars('', container)
            );
            container = ArrayList(u8)
                .init(allocator);
        }
        else {
            try container.append(curr);
        }
    }
    return str_list;
}
