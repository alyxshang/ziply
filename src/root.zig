// Ziply by Alyx Shang.
// Licensed under the FSL v1.

const std = @import("std");
const list = std.ArrayList;
const alloc = std.heap.page_allocator;

pub const ArgData = struct {
    help: [*:0]const u8,
    data: bool,
    name: [*:0]const u8,

    pub export fn new(
        help: [*:0]const u8,
        data: bool,
        name: [*:0]const u8
    ) ArgData {
        return ArgData{
            .help = help,
            .data = data,
            .name = name
        };
    }
};

pub const App = struct {
    name: [*:0]const u8,
    author: [*:0]const u8,
    version: [*:0]const u8,
    args: std.ArrayList(ArgData),

    pub export fn new(
        name: [*:0]const u8,
        author: [*:0]const u8,
        version: [*:0]const u8,
    ) App {
        var arg_arr = list(ArgData).init(alloc);
        defer arg_arr.deinit();
        return App{
            .name = name,
            .args = arg_arr,            
            .author = author,
            .version = version,

        };
    }

    pub export fn arg_was_used(
        arg: [*:0]const u8,
        args: [*:0]const u8,
    ) !bool {
        var option_three_buf: [2]u8 = undefined;
        var option_four_buf: [50]u8 = undefined; // Fix this up.
        const option_one = arg;
        const option_two = arg[0];
        const option_three = try std.fmt.bufPrint(
            &option_three_buf,
            "-{}",
            arg[0]
        );
        const option_four = try std.fmt.bufPrint(
            &option_four_buf,
            "--{}",
            arg
        );
        // TO DO.
    }

};
