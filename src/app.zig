// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library.
const std = @import("std");

// Importing the `ArrayList`
// structure.
const ArrayList = std.ArrayList;

// Importing the `ArgData` structure.
const arg_data = @import("data.zig");

// Importing the `ParsedArg` structure.
const parsed = @import("parsed.zig");

/// This structure holds
/// all data for an app.
pub const App = struct {
    name: [*:0]const u8,
    author: [*:0]const u8,
    version: [*:0]const u8,
    allocator: std.mem.Allocator,
    set_args: ArrayList(arg_data.ArgData),
    parsed_args: ArrayList(parsed.ParsedArg),

    /// Creates a new instance
    /// of the `App`
    /// structure with the 
    /// supplied data.
    pub fn init(
        name: [*:0]const u8,
        author: [*:0]const u8,
        version: [*:0]const u8,
        allocator: std.mem.Allocator
    ) App {
        const set_args = ArrayList(arg_data.ArgData)
            .init(allocator);
        const parsed_args = ArrayList(parsed.ParsedArg)
            .init(allocator);
        return App{
            .name = name,
            .author = author,
            .version = version,
            .allocator = allocator,
            .set_args = set_args,
            .parsed_args = parsed_args
        };
    }
};
