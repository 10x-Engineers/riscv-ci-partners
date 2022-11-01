# Cross-compiling `dhrystone`

Dhrystone is a benchmarking tool. Here `dhrystone` will be compiled from source and run on `qemu-riscv64`.  
Dhrystone is comparable to VAX 11/780 in a way that VAX 11/780 achieves 1757 dhrystones per second which is also referred to as 1 MIPS of VAX11/780. So number of dhrystones per seconds are obtained and then divided by 1757 to get MIPS. See this [link](https://wiki.cdot.senecacollege.ca/wiki/Dhrystone_howto) for more details.

## Cross-compiling for `riscv64-unknown-linux-gnu`

1. Get the source code of `dhrystone` using the command below  

```shell
git clone https://github.com/sifive/benchmark-dhrystone.git
```  

2. Navigate to root directory of repository and compile program with `riscv64-unknown-linux-gnu-gcc` instead of native `gcc`  

```shell
cd benchmark-dhrystone
make CC=riscv64-unknown-linux-gnu-gcc
```  

3. Execute following command to execute `dhrystone` binary  

```shell
qemu-riscv64 -L $RISCV_SYSROOT ./dhrystone
```  

**Note:** You may want to tweak `Makefile` and `dhry_1.c` a little bit to get the correct results.  
