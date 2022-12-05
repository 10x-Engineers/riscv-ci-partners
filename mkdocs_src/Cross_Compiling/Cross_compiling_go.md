# Cross compiling `Go`

Go currenlty has support for riscv64 architecture. This document will cover how to compile go on x86 for riscv64 architecture.

_**Note:** Right now, go can be cross-compiled on x86 but it cannot be executed on x86 with qemu-riscv64 because it needs to execute `goroot/pkg/tool/compile` and qemu-riscv64 can only execute one binary at a time._

## Pre Requisites

On ubuntu, following pre-requisites should be installed.

- Snap
- qemu-riscv64 (linux-user)

Go source code is written in go. That means a go toolchain is needed to compile the source code (see [link](https://go.dev/doc/install/source) ). As this document cross-compiles the code, first of all install a go language on build machine. Use following command on ubuntu to install a go language compiler.

```shell
sudo snap install go --classic
```

After this, get the source code of `go` from following command.

```shell
git clone https://go.googlesource.com/go goroot
```  

Now set the environment variable as follows.

```shell
export GOROOT_BOOTSTRAP=/snap
export GOARCH=riscv64
export GOOS=linux
```

Navigate to `goroot/src` and execute following command.

```shell
./all.bash
```  

After this, an executable file will be located in folder `goroot/bin/linux_riscv64`.
