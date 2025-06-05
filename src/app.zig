// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library.
const std = @import("std");

// Importing the `ArrayList`
// structure.
const list = std.ArrayList;

// Importing one of the standard
// heap allocators.
const allocator = std.heap.page_allocator;

/// This structure holds
/// all data for an app.
pub const App = struct {
    data: [*:0]const u8,
    name: [*:0]const u8,
    version: [*:0]const u8,
    set_args: ArrayList(ArgData),
    parsed_args: ArrayList(ParsedArg)

    /// Creates a new instance
    /// of the `App`
    /// structure with the 
    /// supplied data.
    pub export fn init(
        data: [*:0]const u8,
        name: [*:0]const u8,
        version: [*:0]const u8,
    ) Self {
        var set_args = ArrayList(ArgData)
            .init(allocator);
        var parsed = ArrayList(ParsedArg)
            .init(allocator);
        return App{
            .data = data,
            .name = name,
            .version = version,
            .set_args = set_args,
            .parsed_args = parsed_args
        }
    }

    /// Checks whether an 
    /// argument was registered 
    /// as a part of the app.
    /// A boolean is returned.
    pub export fn arg_was_set(
        self: *const App,
        arg: [*:0]const u8
    ) bool {
        var result: bool = false;
        for (self.set_args) |item, _|{
            ArgData curr = item;
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
    pub export fn arg_was_detected(
        arg: [*:0]const u8,
        self: *const App
    ) bool {
        var result: bool = false;
        for (self.parsed_args) |item, _|{
            ParsedArg curr = item;
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
    pub export fn arg_was_used(
        arg: [*:0]const u8
    ) bool {
        var result: bool = false;
        const parsed: *ArrayList(
        if (
            arg_was_set(arg) && 
            arg_was_detected(arg)
        ){
            result = true;
        }
        else {}
        return result;
    }

    /// Attempts to parse the
    /// arguments supplied
    /// to a program from a 
    /// concatenated string.
    pub export fn parse_args(
        self: *const App,
        arg_data: [*:0]const u8,
    ) void {
    }

    /// Adds an argument to the
    /// list of registered arguments.
    pub export fn add_arg(
        self: *App,
        data: bool,
        name: [*:0]const u8,
        help: [*:0]const u8,
    ) !void {
        try self.set_args.append(
            ArgData.init(data, name, help))
    }

    pub export fn arg_data(
        self: *const App,
        arg: [*:0]const u8
    ) ![*:0]const u8 {
        if (self.arg_was_used(arg)){

        }
        else {
        }
    }

}
