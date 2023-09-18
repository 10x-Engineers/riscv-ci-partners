# Cross Compilation

## Need of Cross Compilation

Lets say you have a computer `A` having processor with architecture `a` and another computer `B` having processor with architecture `b`. Assume computer `A` has all the necessary tools and softwares whereas computer `B` does not have any software, tools, compilers and also the dependencies needed to install these tools and softwares. In this scenario, you cannot download the software setups (say tarballs) directly on computer `B` and have them installed/compiled because they will not be able to get compiled by computer `B` and will be completely useless.

## Basic concept

The basic workflow in such a condition will be as follows:  

1. Install a compiler on computer `A` such that it runs on computer `A` and compiles code for architecture `a`.  
2. Using the above installed compiler, install a compiler on computer `A` such that it runs on computer `A` but compiles code for architecture `b`. Such a compiler is called cross compiler. One example of such a cross-compiler is [RISC-V GNU TOOLCHAIN](https://github.com/riscv-collab/riscv-gnu-toolchain).  
3. Using the above compiled cross compiler, compile all the programs and also the compiler itself for architecture `b`.
4. Port all the compiled binaries to the computer `B`.

Such a process is beneficial if you have created a custom architecture and there is no support available for it.  
Throughout this documentation, the cross compiler used will be RISCV GNU Toolchain mentioned with `riscv64-unknown-linux-gcc` running on `x86_64` and compiling code for `riscv64` architecture whereas the native compiler will be `gcc` running on `x86_64` and compiling code for `x86_64` unless otherwise specified.  
