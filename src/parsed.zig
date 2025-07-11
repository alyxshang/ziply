// Ziply by Alyx Shang.
// Licensed under the FSL v1.

// Importing the standard library.
const std = @import("std");

// Importing a string library.
const xian = @import("xian");

// Importing the data structure
// to handle errors.
const err = @import("err.zig");

// Importing the data structure
// for saving and setting arguments
// an app should accept.
const data = @import("data.zig");

// Importing the "ArrayList"
// data structure from the
// standard library because
// lists will be needed.
const ArrayList = std.ArrayList;

/// A data structure for encapsulating
/// data parsed from the command line
/// for a certain argument.
pub const ParsedArgument = struct {
    name: [*:0]const u8,
    captured: ?[*:0]const u8,

    /// A function to create
    /// a new instance of this
    /// data structure and return
    /// this instance.
    pub fn init(
        name: [*:0]const u8,
        captured: ?[*:0]const u8
    ) ParsedArgument {
        return ParsedArgument{
            .name = name,
            .captured = captured
        };
    }
};

/// Parses a list of strings into a list
/// of instances of the `ParsedArgument`
/// data structure.
pub fn parseArgs(
    arguments: ArrayList(data.ArgData),
    serialized: ArrayList(xian.String),
    allocator: std.mem.Allocator
) !ArrayList(ParsedArgument) {
    var result = ArrayList(ParsedArgument)
        .init(allocator);
    for (serialized.items, 0..) |item, idx| {
        var copy = item;
        const one = copy.get(0)
            catch return err.ZiplyErr.ItemNotFound;
        const two = copy.get(1)
            catch return err.ZiplyErr.ItemNotFound;
        if (one == '-'){
            const itemLen = copy.len() - 1;
            for (1..(itemLen+1)) |i| {
                const curr_letter = copy.get(i)
                    catch return err.ZiplyErr.ItemNotFound;
                const arg_data = matchLetter(
                        curr_letter,
                        allocator,
                        arguments
                    )
                    catch return err.ZiplyErr.ItemNotFound;
                if (arg_data.has_data){
                    var a_data = serialized.items[idx+i];
                    const parsed = ParsedArgument.init(arg_data.name, a_data.asSlice());
                    result.append(parsed)
                        catch return err.ZiplyErr.WriteErr;
                }
                else {
                    const parsed = ParsedArgument.init(arg_data.name, null);
                    result.append(parsed)
                        catch return err.ZiplyErr.WriteErr;
                }
            }
            if (two == '-'){
                _ = copy.remove(0)
                    catch return err.ZiplyErr.WriteErr;
                _ = copy.remove(0)
                    catch return err.ZiplyErr.WriteErr;
                const arg_data = matchWord(
                    item.asSlice(),
                    allocator,
                    arguments
                )
                    catch return err.ZiplyErr.ItemNotFound;
                if (arg_data.has_data){
                    var a_data = serialized.items[idx+1];
                    const parsed = ParsedArgument.init(arg_data.name, a_data.asSlice());
                    result.append(parsed)
                        catch return err.ZiplyErr.WriteErr;
                }
                else {
                   const parsed = ParsedArgument.init(arg_data.name, null);
                   result.append(parsed)
                        catch return err.ZiplyErr.WriteErr;
                }
                
            }
            else {
                return err.ZiplyErr.ParsingErr;
            }
        }
        else {
            const arg_data = matchWord(
                copy.asSlice(),
                allocator,
                arguments
            )
                catch return err.ZiplyErr.ItemNotFound;
            if (arg_data.has_data){
                var a_data = serialized.items[idx+1];
                const parsed = ParsedArgument.init(arg_data.name, a_data.asSlice());
                result.append(parsed)
                    catch return err.ZiplyErr.WriteErr;
            }
            else {
                const parsed = ParsedArgument.init(arg_data.name, null);
                result.append(parsed)
                    catch return err.ZiplyErr.WriteErr;
            }
        }
    }
    return result;
}

/// This function checks whether
/// an argument of the specified name
/// has a setting that says it should
/// accept data or not. A boolean is
/// returned to this effect.
pub fn hasData(
    name: [*:0]const u8,
    argument_list: ArrayList(data.ArgData),
) bool {
    var result = false;
    for (argument_list.items) |item| {
        if (
            xian.compareSlices(item.name, name) and
            item.has_data
        ){
            result = true;
        }
    }
    return result;
}

/// Matches a single word
/// against any of the arguments
/// a user has registered in their 
/// CLI app. If a matching item is
/// found, it is returned. If not,
/// an error is returned.
pub fn matchWord(
    word: [*:0]const u8,
    allocator: std.mem.Allocator,
    arguments: ArrayList(data.ArgData)
) !data.ArgData {
    var result = ArrayList(data.ArgData)
        .init(allocator);
    defer result.deinit();
    for (arguments.items) |arg| {
        if (xian.compareSlices(arg.name, word)){
            result.append(arg)
                catch return err.ZiplyErr.WriteErr;
        }
    }
    if (result.items.len == 1){
        return result.items[0];
    }
    else {
        return err.ZiplyErr.ItemNotFound;
    }
}

/// Matches a single letter
/// against any of the arguments
/// a user has registered in their 
/// CLI app. If a matching item is
/// found, it is returned. If not,
/// an error is returned.
pub fn matchLetter(
    letter: u8,
    allocator: std.mem.Allocator,
    arguments: ArrayList(data.ArgData)
) !data.ArgData {
    var result = ArrayList(data.ArgData)
        .init(allocator);
    defer result.deinit();
    for (arguments.items) |arg| {
        if (arg.name[0] == letter){
            result.append(arg)
                catch return err.ZiplyErr.WriteErr;
        }
    }
    if (result.items.len == 1){
        return result.items[0];
    }
    else {
        return err.ZiplyErr.ItemNotFound;
    }
}
