# ZIPLY :minidisc: :lizard:

![Ziply CI](https://github.com/alyxshang/ziply/actions/workflows/zig.yml/badge.svg)

***Making CLI applications in Zig easy. :minidisc: :lizard:***

## ABOUT :books:

To use the ***Ziply*** package in your Zig project, run the following command
from the root of your Zig project:

```bash
zig fetch --save git+https://github.com/alyxshang/ziply.git
``` 

This will add the ***Ziply*** package to your `build.zig.zon` file.

To also inform the compiler about this new package you would have to also add this library to your `build.zig` build script. 

To use the ***Ziply*** namespace in your Zig code, you would add
the following line to any Zig source code files you want to use this
package in:

```Zig
const zhangshield = @import("ziply");
```

## USAGE :hammer:

To view this package's API please clone this repository and run the command `zig build-lib -femit-docs src/root.zig` from the repository's root or view them [here](https://alyxshang.github.io/ziply). An example project can be viewed in the [`sample`](sample/) directory.

## CHANGELOG :black_nib:

### Version 0.1.0

- Initial release.
- Upload to GitHub.

## NOTE :scroll:

- *Ziply :minidisc: :lizard:* by *Alyx Shang :black_heart:*.
- Licensed under the [FSL v1](https://github.com/alyxshang/fair-software-license).
