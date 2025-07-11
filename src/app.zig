// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library.
const std = @import("std");

// Importing a string library.
const xian = @import("xian");

// Importing the data structure
// to handle errors.
const err = @import("err.zig");

// Importing the "ArrayList"
// data structure from the
// standard library because
// lists will be needed.
const ArrayList = std.ArrayList;

// Importing the data structure
// for setting CLI arguments for
// an app.
const data = @import("data.zig");

/// Importing the module responsible
/// for handling parsing of receieved
/// arguments.
const parsed = @import("parsed.zig");

/// The main data structure
/// the user instantiates
/// when creating a new CLI
/// application.
pub const App = struct{
    name: [*:0]const u8,
    version: [*:0]const u8,
    author: [*:0]const u8,
    allocator: std.mem.Allocator,
    arguments: ArrayList(data.ArgData),
    serialized: ArrayList(xian.String),
   
    /// This function creates
    /// a new instance of the
    /// `App` data structure
    /// and returns it.
    pub fn init(
        name: [*:0]const u8,
        version: [*:0]const u8,
        author: [*:0]const u8,
        serialized: ArrayList(xian.String),
        allocator: std.mem.Allocator
    ) !App {
        const arg_list: ArrayList(data.ArgData) = ArrayList(
            data.ArgData
        )
            .init(allocator);
        return App{
            .name = name,
            .version = version,
            .author = author,
            .allocator = allocator,
            .arguments = arg_list,
            .serialized = serialized,
        };
    }

    /// Registers a further
    /// argument for the instantiated
    /// app with the given data. If this
    /// operation fails, an error is returned.
    pub fn addArg(
        self: *App,
        name: [*:0]const u8,
        help: [*:0]const u8,
        has_data: bool
    ) !void {
        const arg_data = data
            .ArgData
            .init(
                name,
                has_data,
                help,
            );
        self.arguments.append(arg_data)
            catch return err.ZiplyErr.WriteErr;
    }

    /// Checks whether the specified argument
    /// was used or not. A boolean is returned
    /// to this effect.
    pub fn argUsed(
        self: *App,
        name: [*:0]const u8,
    ) !bool {
        var result = false;
        const parsed_args = parsed.parseArgs(
            self.arguments,
            self.serialized,
            self.allocator
        )
            catch return err.ZiplyErr.ParsingErr;
        defer parsed_args.deinit();
        for (parsed_args.items) |item| {
            if (
                xian.compareSlices(item.name, name) and
                data.argWasSet(name, self.arguments)
            ){
                result = true;
            }
        }
        return result;
    }

    /// Returns any captured data the specified
    /// argument *may* accept. If there is data,
    /// it is returned. If the argument is unknown
    /// or no data was captured, an error is returned.
    pub fn getArgData(
        self: *App,
        name: [*:0]const u8
    ) !xian.String {
        const has_data = parsed.hasData(
            name,
            self.arguments
        );
        const arg_was_set = data.argWasSet(
            name,
            self.arguments
        );
        if (has_data and arg_was_set) {
            const parsed_args = parsed.parseArgs(
                self.arguments,
                self.serialized,
                self.allocator
            )
                catch return err.ZiplyErr.ParsingErr;
            defer parsed_args.deinit();
            for (parsed_args.items) |item| {
                if (xian.compareSlices(item.name, name)){
                    if (item.captured) |value| {
                        const new_str = xian
                            .String
                            .init(
                                value,
                                self.allocator
                        )
                            catch return err.ZiplyErr.WriteErr;
                        return new_str;
                    }
                    else {
                        return err.ZiplyErr.ArgSettingsErr;
                    }
                }
            }
            return err.ZiplyErr.ArgSettingsErr;
        }
        else {
            return err.ZiplyErr.ArgSettingsErr;
        }
    }

    /// Checks whether the
    /// version flag was used
    /// as either `version`, 
    /// `--version` or `-v`.
    pub fn versionIs(
        self: *App
    ) bool {
        return self.argUsed("version");
    }

    /// Checks whether the
    /// version flag was used
    /// as either `help`, 
    /// `--help` or `-h`.
    pub fn helpIs(
        self: *App
    ) bool {
        return self.argUsed("version");
    }

    /// Returns a version
    /// string. If the operation
    /// fails, an error is returned.
    pub fn versionMsg(
        self: *App,
    ) !xian.String {
        var name_str = xian
            .String
            .init(
                self.name
            );
        var version_str = xian
            .String
            .init(
                self.version
            );
        const author_str = xian
            .String
            .init(
                self.author
            );
        name_str.appendSlice(" v.")
            catch err.ZiplyErr.WriteErr;
        version_str.appendSlice("\nby")
            catch err.ZiplyErr.WriteErr;
       var str_array = ArrayList(xian.String)
            .init(self.allocator);
        str_array.append(name_str)
            catch err.ZiplyErr.WriteErr;
        str_array.append(version_str)
            catch err.ZiplyErr.WriteErr;
        str_array.append(author_str)
            catch err.ZiplyErr;
        const joiner = xian
            .String
            .init("");
        const result = xian.joinStrings(
            str_array,
            joiner,
            self.allocator
        );
        return result;
    }

    /// Returns a help string.
    /// If the operation fails,
    /// an error is returned.
    pub fn helpMsg(
        self: *App,
    ) !xian.String {
        var str_arr = ArrayList(xian.String)
            .init(self.allocator);
        const joiner = xian.String.init("\n");
        for (self.arguments.items) |item|{
            const single = singleHelp(item)
                catch return err.ZiplyErr.WriteErr;
            str_arr.append(single)
                catch return err.ZiplyErr.WriteErr;
        }
        const result = xian.joinStrings(
            str_arr,
            joiner,
            self.allocator
        );
        return result;
    }

   
    
    /// Drops all heap-allocated memory this
    /// data structure contains.
    pub fn deinit(
        self: *App
    ) void {
        self.arguments.deinit();
        for (self.serialized.items) |*item| {
            item.deinit();
        }
    }
};

/// Generates a new help message
/// for a single registered argument
/// as a string and returns it. If this
/// operation fails, an error is returned.
pub fn singleHelp(
    arg: data.ArgData,
    allocator: std.mem.Allocator
) !xian.String {
    var str_arr = ArrayList(xian.String)
        .init(allocator);
    const minus = xian.String.init("-", allocator);
    minus.push(arg.name[0])
        catch return err.ZiplyErr.WriteErr;
    const double_minus = xian.String.init("--", allocator);
    double_minus.appendSlice(arg.name)
        catch return err.ZiplyErr.WriteErr;
    const single = xian.String.init(arg.name, allocator);
    if (arg.has_data){
        single.appendSlice("DATA  ")
            catch return err.ZiplyErr.WriteErr;
    }
    else {
        single.appendSlice("        ")
            catch return err.ZiplyErr.WriteErr;
    }
    single.appendSlice(arg.help)
        catch return err.ZiplyErr.WriteErr;
    str_arr.append(minus)
        catch return err.ZiplyErr.WriteErr;
    str_arr.append(double_minus)
        catch return err.ZiplyErr.WriteErr;
    str_arr.append(single)
        catch return err.ZiplyErr.WriteErr;
    const joiner = xian.String.init("", allocator);
    const new_str = xian.joinStrings(str_arr, joiner,allocator)
        catch return err.ZiplyErr.WriteErr;
    return new_str;
}
