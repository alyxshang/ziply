// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard
// library.
const std = @import("std");

// Importing the custom error
// type.
const err = @import("err.zig");

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

    /// A function to add an argument
    /// to the app. If the operation 
    /// to do so fails, an error is
    /// returned.
    pub fn addArg(
        self: *App,
        name: [*:0]const u8,
        help: [*:0]const u8,
        data: bool
    ) !void {
        const set: arg_data.ArgData = arg_data.ArgData{
            .data = data,
            .name = name,
            .help = help
        };
        self.set_args.append(set)
            catch return err.ZiplyErr.AllocationErr;
    }

    /// Parses the arguments received
    /// and populates the `parsed_args` 
    /// field. If the operation fails,
    /// an error is returned.
    pub fn parseArgs(
        self: *App,
        args: ArrayList(string.String)
    ) !void {
        var parsed_list: ArrayList(ParsedArg) = ArrayList(ParsedArg)
            .init();
        for (args) |arg| {

        }
        self.parsed_args = list;
    }

    /// Checks if an argument was
    /// used and returns a boolean
    /// depending on this.
    pub fn argWasUsed(
        self: *App,
        name: [*:0]const u8
    ) bool {
        var result: bool = false;
        for (self.parsed_args) |item| {
            if (item.name == name){
                result = true;
            }
        }
        return result;
    }

    /// Checks whether an
    /// argument captured
    /// allows the capturing
    /// of data.
    pub fn isDataAccepted(
        self: *App,
        subject: [*:0]const u8
    ) bool {
        var result: bool = false;
        for (self.set_args) |arg| {
            if (arg.name == subject and arg.data){
                result = true;
            }
        }
        return result;
    }

    /// Traverses the list of parsed
    /// arguments and then 
    pub fn getArgData(
        self: *App,
        name: [*:0]const u8
    ) ![*:0]const u8 {
        var data_array: ArrayList([*:0]const u8) =ArrayList([*:0]const u8)
            .init(self.allocator);
        defer data_array.deinit();
        for (self.parsed_args) |arg| {
            if (arg.name == name){
                if (arg.data){
                    data_array.append(data)
                        catch return err.ZiplyErr.AllocationErr; 
                }
            }
        }
        const data_accepted: bool = self.isDataAccepted(name);
        if (data_array.len == 0){
            if (data_accepted){            
                return err.ZiplyErr.NoDataCaptured;
            }
            else {
                return err.ZiplyErr.NoDataAccepted;
            }
        }
        else {
            return data_array[0];
        }
    }

    /// This function parses the received
    /// command-line arguments and parses
    /// them for further processing. If the
    /// operation fails, an error is returned.
    pub fn parseArgs(
        args: ArrayList(u8)
    ) !void {

    }

    /// Frees up memory occupied
    /// by both `ArrayList` entities
    /// in this structure.
    pub fn deinit(
        self: *App
    ) void {
        self.set_args.deinit();
        self.parsed_args.deinit();
    }

};
