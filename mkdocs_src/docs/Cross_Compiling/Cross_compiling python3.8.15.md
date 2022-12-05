# Cross compiling python3.8.15 for `riscv64`

This document will include how to build python3.8.15 for riscv64 architecture while using build machine as x86_64.  

## Building Python

Get the python source code of python 3.8.15 in form of tarball from [this](https://www.python.org/downloads/source/) link.  

Once a tarball is obtained, extract it and use following command in its root folder to configure it.  

```shell
# Here $PREFIX is the directory where the binaries are desired to be installed.
./configure --host=riscv64-unknown-linux-gnu --build=x86_64-linux-gnu --prefix="$PREFIX" --disable-ipv6 ac_cv_file__dev_ptmx=no ac_cv_file__dev_ptc=no
```

After the above command is executed, use following command to start the build.

```shell
make -j$(nproc)
```  

Now to install binaries on the location where PREFIX, use following command.

```shell
make install
```

This will install binaries for python3.8.15 in the $PREFIX directory and it can be checked using `qemu-riscv64`.
