# Cross-compiling ninja-build for RISC-V

Ninja is a small build system with a focus on speed. It differs from other build systems in two major respects: it is designed to have its input files generated by a higher-level build system, and it is designed to run builds as fast as possible.

This document will cover how to compile ninja to work on 64-bit RISC-V architecture.

## Getting source code

Use following command to get source code of ninja-build and navigate to source directory.

```shell
git clone git://github.com/ninja-build/ninja.git
cd ninja
git checkout release
```

Create following cmake file inside the root directory of ninja-build repository.

```shell
# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER   riscv64-unknown-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER riscv64-unknown-linux-gnu-g++)

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH  /softwares/RISCV/riscv64-unknown-linux-gnu/50c1b734e889e5cbb88bcc7f14975ea9a1d0b936/sysroot
    )

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
```