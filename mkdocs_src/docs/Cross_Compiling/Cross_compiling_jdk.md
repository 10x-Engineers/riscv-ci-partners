# Cross-compiling JDK for `riscv64-unknown-linux-gnu`

JDK is abbreviation of 'Java Development Kit'. It is used for compiling and executing java-based programs and applications.  

All the information regarding building jdk and relevant dependencies are given at  
<https://github.com/openjdk/jdk/blob/master/doc/building.md>  

Make sure to have `riscv64-unknown-linux-gnu` toolchain installed on machine.

## Getting source code  

The source code of jdk can be obtained using command below  

```shell
git clone https://github.com/openjdk/jdk.git
```

## Building the source code for

- First of all configure the source code using the command below  

```shell
bash configure --host=riscv64-unknown-linux-gnu --build=x86_64-linux-gnu --target=riscv64-unknown-linux-gnu --prefix=/home/ali/custom_installed/RISCV/jdk/967a28c3d85fdde6d5eb48aa0edd8f7597772469 --with-cups=/home/ali/custom_installed/cups --with-fontconfig=/home/ali/custom_installed/fontconfig/e291fda7d42e5d64379555097a066d9c2c4efce3 --x-includes=/usr/include --x-lib=/usr/lib
```