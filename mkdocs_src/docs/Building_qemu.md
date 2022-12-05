# Installing `QEMU` for emulating riscv64

`QEMU` is an open-source emulator. It can be used to emulate different architectures on a single machine. In RISC-V CI there are various programs which run on RISC-V architecture. But instead of porting them to a dedicated board of riscv architecture, they can be run readily on qemu emulator. Here two types of `QEMU` emulators will be used for RISC-V applications:  

1. **qemu-system-riscv64:** It can be used to load a complete linux operating system image.  
2. **qemu-riscv64:** It can be used to execute program's binary directly without need of a complete operating system.  

## Installing Pre-requisites

Execute the following command to install the pre-requisites for installing `qemu` on ubuntu 22.04 (jammy)  

```shell
sudo apt-get install meson git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
```  

`qemu-slirp` is important for enabling user-level networking with `qemu-system-riscv64` `qemu-system-riscv64` while loading image of server installation of ubuntu. So it needs to be installed first.  

Get the source code of `qemu-slirp` using following command:  

```shell
git clone https://github.com/openSUSE/qemu-slirp.git
```  

Then Execute following commands to install `slirp` in meson, which can later be used by qemu during build.  

```shell
meson build
ninja -C build install
```  

**Note:** Make sure you have `riscv64-unknown-linux-gnu` toolchain installed for compiling program and executing them on qemu later.

There are some optional dependencies which one can download, but they are actually not needed for installing qemu and make it work.

## Installing `qemu-system-riscv64`

### What is `qemu-system-riscv64`

`qemu-system-riscv64` is qemu executable program. It can load a complete linux distribution. It cannot take program's executable binary as argument and run it without a dedicated linux distribution.

### Installing `qemu-system-riscv64` on ubuntu

- Get source code of `qemu` from github using the command below  

```shell
git clone https://github.com/qemu/qemu.git
```  

- Configure qemu for `riscv64-softmmu` with following command (replace $PREFIX with valid location of installation).  

```shell
./configure --prefix=$PREFIX --target-list=riscv64-linux-user,riscv64-softmmu --enable-slirp  
```

- Execute following command to start the build.  

```shell
make
```

- Execute following command to install the binaries at `$PREFIX` location.  

```shell
make install
```  

_**Note:** After the installation with `slirp` following error can be encountered on some systems_.  

```shell
qemu-system-riscv64: symbol lookup error: qemu-system-riscv64: undefined symbol: slirp_new, version SLIRP_4.0
```

_**Solution:** This can be solved by executing following command in source directory of qemu (which is cloned from github)._  

```shell
[sudo] ldconfig
```

### Testing `qemu-system-riscv64`  

`qemu-system-riscv64` can only be tested by booting a linux operating system. See [Booting RISC-V Ubuntu 22.04 on `qemu-system-riscv64`](Booting_ubuntu22.04_riscv64.md).

## Installing `qemu-riscv64`

### What is `qemu-riscv64`

`qemu-riscv64` is qemu executable program. But instead of porting a complete operating system (like `qemu-system-riscv64`), it can readily execute binaries.  
Throughout cross-compiling section, `qemu-riscv64` will be used with `linux-user` and executable of every program can be tested on qemu (e.g. python, ruby etc.).  

### Installing `qemu-riscv64` on ubuntu 22.04

- Get source code of `qemu` using the command below  

```shell
git clone https://github.com/qemu/qemu.git
```  

- Use following command in the root directory of repository to configure `qemu` for `riscv64-linux-user`  

```shell
./configure --target-list=riscv64-linux-user --prefix=$PREFIX # Replace $PREFIX with a valid location to install at  
```  

**Note:** If this is not your architecture/platform, you can see a list of available platform/architecture by executing following command.  

```shell
./configure --help
```  

- Use the following command to start the build process  

```shell
make -j$(nproc)
```  

- After the builld is complete without any error, use the following command to install binaries at `$PREFIX` location  

```shell
make install
```  

- Add the `$PREFIX/bin` to `$PATH` variable so that it may be recognized as a command.  

- Using this method causes the `qemu-riscv64` to have an issue with sysroot. It starts searching for libraries in the root folder of the machine which is based on `x86_64-linux-gnu`. A simple workaround is to give path of the `sysroot/` folder where  `riscv64-unknown-linux-gnu` toolchain is installed. Here that directory will be denoted as `$RISCV_SYSROOT`

### Testing `qemu-riscv64`

- Create a C file in your favorite editor or by using the commands below:  

```shell
echo "#include<stdio.h>" > helloworld.c
echo "int main(){" >> helloworld.c
echo "printf("Hello World !");" >> helloworld.c
echo '}' >> helloworld.c
```  

- Execute following command to compile C program with `riscv gnu toolchain`  

```shell
riscv64-unknown-linux-gnu-gcc helloworld.c -o helloworld
```  

- Execute following command to execute the compiled binary on `qemu-riscv64`  

```shell
qemu-riscv64 -L $RISCV_SYSROOT ./helloworld
```  

- If everything went right, following output will be shown.  

```shell
Hello World !
```
