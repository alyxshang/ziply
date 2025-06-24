// Ziply by Alyx Shang.
// Licensed under the FSL v1.

/// This structure holds all
/// data parsed from the string 
/// obtained from all argument
/// data supplied to a program.
pub const ParsedArg = struct {
    name: [*:0]const u8,
    verb: [*:0]const u8,
    data: ?[*:0]const u8,

    /// Creates a new instance
    /// of the `ParsedArg`
    /// structure with the 
    /// supplied data.
    pub fn init(
        name: [*:0]const u8,
        verb: [*:0]const u8,
        data: ?[*:0]const u8
    ) ParsedArg {
        return ParsedArg{
            .name = name,
            .verb = verb,
            .data = data
        };
    }
};
