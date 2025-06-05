// Ziply by Alyx Shang.
// Licensed under the FSL v1.

/// This structure holds all
/// data on an argument added
/// to a Ziply app.
pub const ArgData = struct {
    pub data: bool,
    pub name: [*:0]const u8,
    pub help: [*:0]const u8,

    /// Creates a new instance
    /// of the `ArgData`
    /// structure with the 
    /// supplied data.
    pub export fn init(
        data: bool,
        name: [*:0]const u8,
        help: [*:0]const u8
    ) Self {
        return ArgData{
            .data = data,
            .name = name,
            .help = help
        };
    }
};
