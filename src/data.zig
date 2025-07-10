// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library.
const std = @import("std");

// Importing a string library.
const xian = @import("xian");

// Importing the "ArrayList"
// data structure from the
// standard library because
// lists will be needed.
const ArrayList = std.ArrayList;

/// A data structure to store
/// information about the CLI
/// arguments an app provides.
pub const ArgData = struct {
    help: [*:0]const u8,
    name: [*:0]const u8,
    has_data: bool,

    /// Creates a new instance
    /// of this data structure
    /// and returns this instance.
    pub fn init(
        name: [*:0]const u8,
        has_data: bool,
        help: [*:0]const u8
    ) ArgData {
        return ArgData {
            .name = name,
            .help = help,
            .has_data = has_data
        };
    }
};

/// A function to check whether
/// an argument of the specified
/// name was actually set as being
/// accepted by the app or not. A 
/// boolean to this effect is returned.
pub fn argWasSet(
    name: [*:0]const u8,
    list: ArrayList(ArgData)
) bool {
    var result = false;
    for (list.items) |item| {
        if (xian.compareSlices(item.name, name)){
            result = true;
        }
    }
    return result;
}
