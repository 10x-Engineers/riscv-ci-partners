# What is `qemu-riscv64`

`qemu-riscv64` is the qemu emulator. But instead of porting a complete operating system (like `qemu-system-riscv64`), it can readily execute binaries.  
Throughout cross-compiling section, `qemu-riscv64` will be used with `linux-user` and executable of every program can be tested on qemu (e.g. python, ruby etc.).  

## Installing Pre-requisites

Execute the following command to install the pre-requisites for installing `qemu` on ubuntu 22.04 (jammy)  

```shell
sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
```  

**Note:** Make sure you have `riscv-unknown-linux-gnu` toolchain installed.

There are some optional dependencies which one can download, but they are actually not needed for installing qemu and make it work.

## Installing `qemu-riscv64` on ubuntu 22.04

1. Get source code of `qemu` using the command below  

```shell
git clone https://github.com/qemu/qemu.git
```  

2. Use following command in the root directory of repository to configure `qemu` for `riscv64-linux-user`  

```shell
./configure --target-list=riscv64-linux-user --prefix=$PREFIX # Replace $PREFIX with a valid location to install at
```  

**Note:** If this is not your architecture/platform, you can see a list of available platform/architecture by executing following command

```shell
./configure --help
```

3. Use the following command to start the build process  

```shell
make -j$(nproc)
```

4. After the builld is complete without any error, use the following command to install binaries at $PREFIX location  

```shell
make install
```  

5. Add the $PREFIX/bin to $PATH variable so that it may be recognized as a command.  

6. Using this method causes the `qemu-riscv64` to have an issue with sysroot. It starts searching for libraries in the root folder of the machine which is based on `x86_64-linux-gnu`. A simple workaround is to give path of the `sysroot/` folder where  `riscv64-unknown-linux-gnu` toolchain is installed. Here that directory will be denoted as `$RISCV_SYSROOT`

## Testing `qemu-riscv64`

1. Create a C file in your favorite editor or by using the commands below:  

```shell
echo "#include<stdio.h>" > helloworld.c
echo "int main(){" >> helloworld.c
echo "printf("Hello World !");" >> helloworld.c
echo '}' >> helloworld.c
```  

2. Execute following command to compile C program with `riscv gnu toolchain`  

```shell
riscv64-unknown-linux-gnu-gcc helloworld.c -o helloworld
```  

3. Execute following command to execute the compiled binary on `qemu-riscv64`  

```shell
qemu-riscv64 -L $RISCV_SYSROOT ./helloworld
```  

4. If everything went right, following output will be shown.  

```shell
Hello World !
```