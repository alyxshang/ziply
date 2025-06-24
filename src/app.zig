// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library.
const std = @import("std");

// Importing the `ArrayList`
// structure.
const ArrayList = std.ArrayList;

// Importing one of the standard
// heap allocators.
const allocator = std.heap.page_allocator;

const parsed = @import("parsed.zig");

const data = @import("data.zig");

/// This structure holds
/// all data for an app.
pub const App = struct {
    data: [*:0]const u8,
    name: [*:0]const u8,
    version: [*:0]const u8,
    set_args: ArrayList(data.ArgData),
    parsed_args: ArrayList(parsed.ParsedArg),

    /// Creates a new instance
    /// of the `App`
    /// structure with the 
    /// supplied data.
    pub fn init(
        data: [*:0]const u8,
        name: [*:0]const u8,
        version: [*:0]const u8,
    ) Self {
        var set_args = ArrayList(data.ArgData)
            .init(allocator);
        var parsed = ArrayList(parsed.ParsedArg)
            .init(allocator);
        return App{
            .data = data,
            .name = name,
            .version = version,
            .set_args = set_args,
            .parsed_args = parsed_args
        };
    }

    /// Checks whether an 
    /// argument was registered 
    /// as a part of the app.
    /// A boolean is returned.
    pub fn arg_was_set(
        self: *const App,
        arg: [*:0]const u8
    ) bool {
        var result: bool = false;
        for (self.set_args) |item|{
            const curr: data.ArgData = item;
            if (curr.name == arg){
                result = true;
            }
            else {}
        }
        return result;
    }

    /// Checks whether an argument
    /// was used in the parsed arguments.
    /// A boolean is returned.
    pub fn arg_was_detected(
        arg: [*:0]const u8,
        self: *const App
    ) bool {
        var result: bool = false;
        for (self.parsed_args) |item|{
            const curr: parsed.ParsedArg = item;
            if (curr.name == arg){
                result = true;
            }
            else {}
        }
        return result;
    }

    /// Checks whether an 
    /// argument was set and
    /// used. A boolean is
    /// returned.
    pub fn arg_was_used(
        arg: [*:0]const u8
    ) bool {
        var result: bool = false;
        if (arg_was_set(arg) and 
            arg_was_detected(arg))
        {
            result = true;
        }
        else 
        {
            result = false;
        }
        return result;
    }

    /// Attempts to parse the
    /// arguments supplied
    /// to a program from a 
    /// concatenated string.
    pub fn parse_args(
        self: *const App,
        arg_data: [*:0]const u8,
    ) void {
    }

    /// Adds an argument to the
    /// list of registered arguments.
    pub fn add_arg(
        self: *App,
        data: bool,
        name: [*:0]const u8,
        help: [*:0]const u8,
    ) !void {
        try self.set_args.append(
            data.ArgData.init(data, name, help));
    }
};
