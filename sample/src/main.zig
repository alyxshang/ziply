const std = @import("std");
const ziply = @import("ziply");

pub fn main() !void {
    const serialized = ziply.serializeArgs(
        std.process.args(),
        std.heap.page_allocator
    );
    defer serialized.deinit();
    var new_app = ziply.App.init(
        "Test",
        "v.0.1.0",
        "Alyx Shang",
        std.heap.page_allocator
    );
    defer new_app.deinit();
    try new_app.addArg(
        "yeet",
        "Yeets the user.",
        false
    );
    try new_app.addArg(
        "version",
        "prints version info.",
        false
    );
    try new_app.addArg(
        "help",
        "prints this message.",
        false
    );
    if (new_app.argUsed("yeet")){
        std.debug.print("Yeet!\n", .{});
    }
    else if (new_app.versionIs()){
        std.debug.print("{c}\n", .{new_app.version().asSlice()});
    }
    else {
       std.debug.print("{c}\n", .{new_app.help().asSlice()});
    }

}
