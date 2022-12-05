# Cross-compiling Coremark  

Coremark is another benchmarking tool. Here coremark will be cross-compiled for `riscv64-unknown-linux-gnu` and will be run on `qemu-riscv64`.  The github source code commit at the time of build is `eefc986ebd3452d6adde22eafaff3e5c859f29e4` and branch is `main`.  

## Getting the source code

Execute the following command to get the source code of coremark.  

```shell
git clone https://github.com/eembc/coremark.git
```  

## Tweaking source files for `riscv64-unknown-linux-gnu`

At the time of this documentation, linux is being used for this test. First of all `core_portme.mak` will be changed.  

1. Navigate to `linux/` directory in source repository.  
2. Open `core_portme.mak`. Here a single line will be used to include `core_portme.mak` from `posix` directory. So, navigate to `posix/` directory in source folder
3. Open `core_portme.mak` in `posix/` directory and do the following changes to variables here.  
    1. Change `CC?=cc` to `CC=riscv64-unknown-linux-gnu-gcc`.
    2. Scroll down and change `EXE=.exe` to `EXE=` (it should be blank).
    3. Scroll down and change `LD=gcc` to `LD=riscv64-unknown-linux-gnu-ld`.
    4. As we are using `qemu-riscv64`, so change `RUN=` to `RUN=qemu-riscv64 -L "$$RISCV_SYSROOT"`
    5. Save changes and exit this file.  
4. Now open `core_portme.h` and change `#define USE_CLOCK 0` to `#define  USE_CLOCK 1` and save.
5. Navigate to source directory of repository and execute following command  

```shell
make PORT_DIR=linux/
```  

If everything went right, the output result will be stored in `run1.log` and `run2.log` and will be of the form as shown below.  

```shell
2K validation run parameters for coremark.
CoreMark Size    : 666
Total ticks      : 12368459
Total time (secs): 12.368459
Iterations/Sec   : 8893.589735
Iterations       : 110000
Compiler version : GCC12.2.0
Compiler flags   : -O2 -DPERFORMANCE_RUN=1  -lrt
Memory location  : Please put data memory location here
			(e.g. code in flash, data on heap etc)
seedcrc          : 0x18f2
[0]crclist       : 0xe3c1
[0]crcmatrix     : 0x0747
[0]crcstate      : 0x8d84
[0]crcfinal      : 0x0956
Correct operation validated. See README.md for run and reporting rules.
```