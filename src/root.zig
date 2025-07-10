// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Declaring the error module.
const err = @import("err.zig");

// Declaring the main module
// for creating a CLI app.
const app = @import("app.zig");

// Declaring the module for
// registering data for a CLI
// application.
const data = @import("data.zig");

// Declaring the module containing
// functionality to encapsulate
// arguments parsed from the command
// line.
const parsed = @import("parsed.zig");

// Declaring the module containing
// functionality to serialize arguments
// into a Zig-friendly data structure.
const serializer = @import("serializer.zig");

// Exporting the module for handling 
// errors in this library.
pub usingnamespace err;

// Exporting the main module
// for creating a CLI app.
pub usingnamespace app;

// Exporting the module
// for registering application
// data.
pub usingnamespace data;

// Exporting the module
// containing functionality
// for encapsulating arguments
// parsed from the command line.
pub usingnamespace parsed;

// Exporting the module containing
// functionality to serialize arguments
// into a Zig-friendly data structure.
pub usingnamespace serializer;

