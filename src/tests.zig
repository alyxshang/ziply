// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library to use the 
// "expect" function.
const std = @import("std");

// Making an alias for the
// "expect" function.
const expect = std.testing.expect;

// Importing the "root" module
// to test it.
const shield = @import("root.zig");

// Testing the "is_letter"
// function for a "true"
// and "false" case,
// respectively.
test "Is a letter." {
    try expect(shield.is_letter('a'));
}
