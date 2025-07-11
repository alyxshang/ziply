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

// Importing the "ArrayList"
// data structure from the
// standard library because
// lists will be needed.
const ArrayList = std.ArrayList;

// Testing the "App.init", "App.addArg",
// and "ArgData.init" functions.
test "Testing basic methods of the key data structures." {
    var arg_list = ArrayList(xian.String)
        .init(std.testing.allocator);
    const arg_one = try xian.String.init(
        "yeet", 
        std.testing.allocator
    );
    try arg_list.append(arg_one);
    var new_app = try app.App.init(
        "Test",
        "v.0.1.0",
        "Alyx Shang",
        arg_list,
        std.testing.allocator
    );
    defer new_app.deinit();
    try new_app.addArg(
        "yeet",
        "Yeets the user.",
        false
    );
    try expect(new_app.arguments.items.len == 2);
    for (arg_list.items) |*item| {
        item.deinit();
    }
    arg_list.deinit();
}

// Testing the "App.argUsed" function.
test "Testing the \"App.argUsed\" function." {
    var arg_list = ArrayList(xian.String)
        .init(std.testing.allocator);
    const arg_one = try xian.String.init(
        "yeet", 
        std.testing.allocator
    );
    try arg_list.append(arg_one);
    var new_app = try app.App.init(
        "Test",
        "v.0.1.0",
        "Alyx Shang",
        arg_list,
        std.testing.allocator
    );
    defer new_app.deinit();
    try new_app.addArg(
        "yeet",
        "Yeets the user.",
        false
    );
    const arg_used = try new_app.argUsed("yeet");
    try expect(arg_used);
}

// Testing the "App.getArgData" function.
test "Testing the \"App.getArgData\" function." {
    var arg_list = ArrayList(xian.String)
        .init(std.testing.allocator);
    defer arg_list.deinit();
    var arg_one = try xian.String.init(
        "yeet", 
        std.testing.allocator
    );
    defer arg_one.deinit();
    var arg_two = try xian.String.init(
        "Alyx", 
        std.testing.allocator
    );
    defer arg_two.deinit();
    try arg_list.append(arg_one);
    try arg_list.append(arg_two);
    var new_app = try app.App.init(
        "Test",
        "v.0.1.0",
        "Alyx Shang",
        arg_list,
        std.testing.allocator
    );
    defer new_app.deinit();
    try new_app.addArg(
        "yeet",
        "Yeets the user.",
        true
    );
    const data = try new_app.getArgData("yeet");
    var copy = data;
    try expect(
        xian.compareSlices(
            copy.asSlice(), 
            arg_two.asSlice()
        )
    );
}

// Testing the "App.versionIs" function.
test "Testing the \"App.versionIs\" function." {

}
