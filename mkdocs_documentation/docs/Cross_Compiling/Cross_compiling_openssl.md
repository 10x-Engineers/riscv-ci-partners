# Cross-compiling openssl

## What is `openssl`  

Openssl is a software library which is used inside many high level languages (e.g. Python, Ruby etc.) and also in linux itself. It is used for security and other cryptography applications.  

## Building openssl v1.0.1 for `riscv64` architecture

Following are the steps used to build openssl for riscv64 architecture.  

1. Get the source code of `openssl` and navigate inside the cloned repository using the commands below

```shell
git clone https://github.com/openssl/openssl.git
cd openssl
```

2. Configure openssl for building. In openssl there are some `os/compiler` choices which one can use to build for his architecture. But in our case there is no support for building with riscv64. As it is written in C language, so it can be compiled whether or not the support is given. Use the following command to generate a `Makefile` for `linux-generic64`

```shell
./Configure linux-generic64 --prefix=$PREFIX # Prefix is the directory where you want binaries to be installed at the end
```

3. After the above command is successfully completed, run the following command to build openssl using `riscv64-unknown-linux-gnu-gcc` compiler instead of native gcc compiler.

```shell
make -j$(nproc) CC=riscv64-unknown-linux-gnu-gcc
```

4. Install the binaries in the specified `--prefix` using the command below

```shell
make -j$(nproc) install CC=riscv64-unknown-linux-gnu-gcc
```

The installed binary can be tested on `qemu-riscv64` using the command below:

```shell
qemu-riscv64 -L $RISCV_SYSROOT ./openssl
```

Here $RISCV_SYSROOT is the `sysroot/` folder located inside the riscv gnu toolchain installed directory.

The above mentioned command will start the openssl console if everything went right.  

**Note:** Do not change the directory of openssl or rename it, as it some files inside it are inferred with absolute paths, changing the directory or renaming it will cause other packages to not configure openssl for them when cross-compiling.  

## Building openssl v1.1.1r for `riscv64` architecture  

In openssl v1.1.1r, there is a support for `linux64-riscv64`. Following is the procedure for cross-compilation.  

1. Checkout the `v1.1.1r` of openssl by executing following command in the repository directory.  

```shell
git checkout OpenSSL_1_1_1r
```

2. Execute following command to configure for riscv64 architecture and generate a `Makefile`.  

```shell
./Configure linux64-riscv64 --prefix=$PREFIX # Replace $PREFIX with where you want to install binaries
```  

3. Execute following command to cross-compile for `riscv64-unknown-linux-gnu`.  

```shell
make CROSS_COMPILE=riscv64-unknown-linux-gnu-
```  

4. Then install binaries at `$PREFIX` with following command.  

```shell
make install
```  

### Solving post-installation errors  

On some operating systems, the installed binaries may not run properly and will give following error.  

```
./openssl: error while loading shared libraries: libssl.so.1.1: cannot open shared object file: No such file or directory
```  
This means that shared libraries cannot be found in the path where the system is looking for them. This can be solved by setting `LD_LIBRARY_PATH` variable as follows.  

```shell
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
```  

It will be a good practice to include the above in the `bashrc` for debian users.