const std = @import("std");
const ziply = @import("ziply");
const ArrayList = std.ArrayList;

pub fn main() !void {

    // Converting the standard argument iterator
    // into an array of strings.
    const arg_list: ArrayList(ziply.String) = ziply.arrayFromArgs(
        std.process.args(),
        std.heap.page_allocator
    );

    // Making a new CLI application.
    const my_app: ziply.App = ziply.App.init(
        "Greeter",
        "Alyx Shang",
        "0.1.0",
        arg_list,
        std.heap.page_allocator
    );

    // Freeing the occupied memory.
    defer my_app.deinit();

    // Adding some arguments.
    my_app.addArg("greet", "Greets the person.", false)
        catch std.debug.print("Error adding an argument.");
    my_app.addArg("name", "Greets with a custom name.", true)
        catch std.debug.print("Error adding an argument.");
    
    if (my_app.argWasUsed("greet")){
    }
    else if (my_app.argWasUsed("name")){

    }
    else if (my_app.helpUsed()){
        std.debug.print("{s}\n", .{my_app.version()});    
    }
    else if (my_app.versionUsed()){
        std.debug.print("{s}\n", .{my_app.version()});
    }
    else {
        std.debug.print("{s}\n", .{my_app.help()});
    }
}
