# Tools on Cloud-V

Following are the tools and libraries available in Cloud-V.

## Tools on `x86_runner1` and `qemuusermode_runner1` node

Tools which are mentioned for `x86` architecture are able to run on`x86_runner2`. Tools which are mentioned for `RISC-V` architecture are able to run on `qemuusermode_runner1`.  

**Operating System:** Debian 11 (bullseye)

| Tool | Version | Installed from | Host Architecture |
| ---- | ------- | -------------- | ------------ |
| RISC-V GNU Linux Toolchain | 12.2.0 | source | x86 |
| Git | 2.3.0.2 | source | x86 |
| OpenJDK | 19.0.1 | apt | x86 |
| GCC | 10.4.0 | apt | x86 |
| Python3 | 3.8.15 | source | x86 |
| Python3 | 3.9.2 | apt | x86 |
| Python3 | 3.8.15 | source | RISC-V |
| zlib | 1.2.13 | source | RISC-V |
| OpenSSL | 1.1.1r | source | RISC-V |
| Ruby (without IRB) | 3.2.0dev | source | RISC-V |
| Go | 1.18.8 | apt | x86 |
| rustc | 1.65.0 | source | RISC-V,x86 |
| Flex | 2.6.4 | apt | x86 |
| Ninja | 1.10.1-1 | apt | x86 |
| Bison | 3.7.5 | apt | x86 |  
| clang | 16.0.0 | source | RISC-V |
| autoconf | 2.69 | apt | x86 |
| gperf | 2.2.4 | apt | x86 |

## Tools on `riscv64_runner1` node

This is compute instance with 64-bit RISC-V Linux and it has all the packages ONLY for RISC-V architecture  

**Operating System:** Ubuntu 22.04.1 (jammy)

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

## Tools on `hifive_unleashed` node

This is compute instance is hifive unleased board and it has all the packages ONLY for RISC-V architecture.  

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
