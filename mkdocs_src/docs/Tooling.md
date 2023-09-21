# Tools on Cloud-V

## Using Environment Modules

Users can use environment modules to load different versions of same program. For using environment modules the pattern is as follows:

```shell
module load <PACKAGENAME/VERSION>
```  

For example if you want to load python version 3.9.2 compiled for x86, you will need to use following command:  

```shell
module load python/3.9.2
```  

For packages compiled for RISC-V architecture host, you will need to append `_riscv` to package name. For example, for python 3.8.15 compiled for RISC-V, following command will be used.  

```shell
module load python_riscv/3.8.15
```

Following are the tools and libraries available in Cloud-V.

## Tools on `x86_runner1` and `qemuusermode_runner1` node

Tools which are mentioned for `x86` architecture are able to run on`x86_runner2`. Tools which are mentioned for `RISC-V` architecture are able to run on `qemuusermode_runner1`.  

The packages which are supported for `QEMU User mode` can be used by normal commands once they are loaded.

Here `PACKAGE_NAME` is the package which you want to run on QEMU user mode.

**Operating System:** Debian 11 (bullseye)  
**QEMU User Mode Version:** 7.1.0

| Tool | Versions | Installed from | Host Architecture | Environment Modules Support |
| ---- | ------- | -------------- | ------------ | ------------ |
| RISC-V GNU Linux Toolchain | 12.2.0 | source | x86 | N/A |
| Git | 2.3.0.2 | source | x86 | N/A |
| OpenJDK | 19.0.1 | apt | x86 | N/A |
| GCC | 10.4.0, 12.2.0 | apt | x86 | Yes |
| Python3 | 3.8.15, 3.9.2 | source | x86 | Yes |
| Python3 | 3.8.15 | source | RISC-V | Yes |
| zlib | 1.2.13 | source | RISC-V | N/A |
| OpenSSL | 1.1.1r | source | RISC-V | Yes |
| Ruby (without IRB) | 3.2.0dev | source | RISC-V | Yes |
| Go | 1.18.8 | apt | x86 | N/A |
| rustc | 1.65.0 | source | RISC-V,x86 | N/A |
| Flex | 2.6.4 | apt | x86 | N/A |
| Flex | 2.6.4 | source | RISC-V | yes
| Ninja | 1.10.1-1 | apt | x86 | N/A |
| Ninja | 1.12.0.git | source | RISC-V | Yes |
| Bison | 3.7.5 | apt | x86 | N/A |
| Bison | 3.8.2, 2.3 | source | RISC-V | Yes |
| clang | 16.0.0 | source | RISC-V | Yes |
| autoconf | 2.69 | apt | x86 | N/A |
| gperf | 2.2.4 | apt | x86 | N/A |
| spike | 1.1.1-dev | source | x86 | Yes |
| Verilator | 4.038 | apt | x86 | N/A |
| riscv-pk | 1.0.0-91-g573c858 | source | RISC-V | Yes |
| Sail (riscv_sim_RV64, riscv_sim_RV32) | 0.5 | source | x86 | Yes |
| cmake | 3.18.4 | apt | x86 | N/A |
| make | 4.3 | apt | x86 | N/A |

## Tools on `riscv64_runner1` node

This is compute instance with 64-bit RISC-V Linux and it has all the packages ONLY for RISC-V architecture  

**Operating System:** Ubuntu 22.04.1 (jammy)  
**QEMU Linux Version:** 7.1.90

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.34.1 | apt |
| OpenJDK | 19.0.1 | apt |
| GCC | 11.3.0 | apt |
| Python3 | 3.10.6 | apt |
| zlib | 1.2.11 | apt |
| OpenSSL | 3.0.2 | apt |
| Ruby | 3.0.2p107 | apt |
| Go | 1.18.8 | apt |
| rustc | 1.61.0 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.10.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| make | 4.3 | apt |
| cmake | 3.22.1 | apt |

## Tools on `hifive_unleashed` node

This compute instance is Sifive's HiFive Unleased board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Fedora 32 (Rawhide)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.23.0 | dnf |
| OpenJDK | 11 | dnf |
| GCC | 9.2.1 | dnf |
| Python3 | 3.8.1 | dnf |
| OpenSSL | 1.1.1d | dnf |
| Ruby | 2.5.1p57 | dnf |
| Go | 1.12.2 | dnf |
| rustc | 1.66.0 | dnf |
| Flex | 2.6.4 | dnf |
| Ninja | 1.9.0 | dnf |
| Bison | 3.4.1 | dnf |
| autoconf | 2.69 | dnf |
| make | 4.2.1 | dnf |
| cmake | 3.14.5 | dnf |

## Tools on `starfive_visionfive2` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Debian Unstable (Bookworm)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.36.1 | apt |
| OpenJDK | 17.0.3 | apt |
| GCC | 11.3.0 | apt |
| Python3 | 3.8.1 | apt |
| OpenSSL | 1.1.1f | apt |
| Ruby | 3.0.4p208 | apt |
| Go | 1.18.3 | apt |
| rustc | 1.59.0 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.0 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.23.2 | apt |
| make | 4.3 | apt |
