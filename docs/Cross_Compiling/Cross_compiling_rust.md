# Cross-compiling rust  

Rust is a programming language just like C but it focuses on safety of programs. This document describes how one can build rust for x86_64 and then add support to compile code for `riscv64` architecture. The executable for RISC-V architecture will be able to run on `qemu-riscv64`.  

_**Note:** Make sure riscv64-unknown-linux-gnu toolchain is installed on the machine._

## Getting source code  

Here the code will be taken from `rustup` GitHub repository. This is because instead of installing `cargo`, `rustup` and `rustc`, just compiling rustup will compile them along with itself.

Get the source code using the command below:

```shell
git clone https://github.com/rust-lang/rustup.git
```

Before starting installation process, if you want to install rust in a specific location, then set `CARGO_HOME` and `RUSTUP_HOME` variable in the directory where you want to install rustup.  

After that, considering you are in the repository directory, start the installation process using the command below:

```shell
sh rustup-init.sh -y
```  

After execution above command, follow the prompts as desired and complete the installation process.

Now add riscv64 library support in rust using the command below:  

```shell
rustup target add riscv64gc-unknown-linux-gnu
```

Once this is complete, go to the desired location where a new project is to be created and use following command to create a project's directory structure.  

```shell
cargo new project_name # Use a meaningful project name
```  

A directory with name `project_name` will be created as soon as the above command is executed successfully. This project will contain a `main.rs` which initially contains a `Hello World` program.  

Navigate to the `project_name` directory and create a folder with name `.cargo`, this will include a `config.toml` file inside it, which will tell it cargo during build that what is the target for which the compilation is to be done. The contents of the `project_name/.cargo/config.toml` will be as follows:  

```shell
[build]
target = "riscv64gc-unknown-linux-gnu"

[target.riscv64gc-unknown-linux-gnu]
linker = "riscv64-unknown-linux-gnu-gcc"
```  

Now the project will be ready to build. Get back to the `project_name/` directory and use following command to build the `main.rs` file:  

```shell
cargo build
```  

The output of the above command should as follows:  

```shell
   Compiling myproject v0.1.0 (project_name)
    Finished dev [unoptimized + debuginfo] target(s) in 0.27s
```

After the above command, the executable with the name `project_name` will be available at following location:  

```shell
project_name/target/riscv64gc-unknown-linux-gnu/debug
```  

Now the produced executable can be executed using qemu usermode. Use the following command to execute binary:  

```shell
qemu-riscv64 -L $RISCV_SYSROOT ./project_name
```
