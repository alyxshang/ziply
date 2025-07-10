// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library.
const std = @import("std");

// Importing a string library.
const xian = @import("xian");

// Importing the module containing
// the main "App" data structure.
const app = @import("app.zig");

// Aliasing the "expect" function
// from the standard library.
const expect = std.testing.expect;

// Testing the "App.init", "App.addArg",
// and "ArgData.init" functions.
test "Testing basic methods of the key data structures." {
    var new_app = app.App.init(
        "Test",
        "v.0.1.0",
        "Alyx Shang",
        std.testing.allocator
    );
    defer new_app.deinit();
    try new_app.addArg(
        "greet",
        "Greets the user.",
        false
    );
    try new_app.addArg(
        "yeet",
        "Yeets the user.",
        false
    );
    try expect(new_app.arguments.items.len == 2);
}


