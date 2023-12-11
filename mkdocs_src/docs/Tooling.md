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

## Tools on `p1` and `qemuusermode_runner1` node

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

## Tools on `qemu-linux1` node

This is QEMU system compute instance with 64-bit RISC-V Linux and it has all the packages ONLY for RISC-V architecture  

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

## Tools on `unleashed1-1` node

This compute instance is Sifive's HiFive Unleased board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 20.04.6 (Focal Fossa)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.25.1 | apt |
| OpenJDK | 11.0.20.1 | apt |
| GCC | 10.5.0 | apt |
| Python3 | 3.8.10 | apt |
| OpenSSL | 1.1.1f | apt |
| Ruby | 2.7.0p0 | apt |
| Go | 1.14.3 | apt |
| rustc | 1.41.0 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.10.0 | apt |
| Bison | 3.5.1 | apt |
| autoconf | 2.69 | apt |
| gperf | 3.1 | apt |
| cmake | 3.16.3 | apt |
| make | 4.2.1 | apt |
| automake | 1.16.1 | apt |
| gfortran | 9.4.0 | apt |
| openssh-server | 8.2p1 | apt |

## Tools on `sf1-1` node

This compute instance is Starfive's VisionFive 1 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf1-2` node

This compute instance is Starfive's VisionFive 1 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf1-3` node

This compute instance is Starfive's VisionFive 1 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf2-1` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf2-2` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf2-3` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf2-4` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |

## Tools on `sf2-5` node

This compute instance is Starfive's VisionFive 2 board and it has available packages ONLY for RISC-V architecture.  

**Operating System:** Ubuntu 23.04 (Lunar Lobster)

| Tool | Version | Installed from |
| ---- | ------- | -------------- |
| Git | 2.39.2 | apt |
| OpenJDK | 21-ea | apt |
| GCC | 13.1.0 | apt |
| Python3 | 3.11.4 | apt |
| OpenSSL | 3.0.8 | apt |
| Ruby | 3.1.2p20 | apt |
| Go | 1.20.3 | apt |
| rustc | 1.67.1 | apt |
| Flex | 2.6.4 | apt |
| Ninja | 1.11.1 | apt |
| Bison | 3.8.2 | apt |
| autoconf | 2.71 | apt |
| gperf | 3.1 | apt |
| cmake | 3.25.1 | apt |
| make | 4.3 | apt |
| automake | 1.16.5 | apt |
| gfortran | 13.1.0 | apt |
| openssh-server | 9.0p1 | apt |
