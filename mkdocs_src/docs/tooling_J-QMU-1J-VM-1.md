# Tools on `J-x86-1` or `J-QMU-1` node

Tools which are mentioned for `x86` architecture are able to run on`J-x86-1`. Tools which are mentioned for `RISC-V` architecture are able to run on `J-QMU-1`.

The packages which are supported for `QEMU User mode` can be used by normal commands once they are loaded.

Here `PACKAGE_NAME` is the package which you want to run on QEMU user mode.

**Operating System:** Debian 11 (bullseye)  
**QEMU User Mode Version:** Different Versions (see the table below)

## Tooling available for `J-x86-1`

The tools available for `J-x86-1` is for use on x86 architecture and these tools do not support execution on RISC-V architecture

| Tool | Versions | Installed from | Host Architecture | Environment Modules Support |
| ---- | ------- | -------------- | ------------ | ------------ |
| Git | 2.3.0.2 | source | x86 | N/A |
| OpenJDK | 19.0.1 | apt | x86 | N/A |
| GCC | 10.4.0, 12.2.0 | apt | x86 | Yes |
| Python3 | 3.8.15, 3.9.2 | source | x86 | Yes |
| Go | 1.18.8 | apt | x86 | N/A |
| rustc | 1.65.0 | source | x86 | N/A |
| Flex | 2.6.4 | apt | x86 | N/A |
| Ninja | 1.10.1-1 | apt | x86 | N/A |
| Bison | 3.7.5 | apt | x86 | N/A |
| autoconf | 2.69 | apt | x86 | N/A |
| gperf | 2.2.4 | apt | x86 | N/A |
| spike | 1.1.1-dev | source | x86 | Yes |
| Verilator | 4.038 | apt | x86 | N/A |
| Sail (riscv_sim_RV64, riscv_sim_RV32) | 0.5 | source | x86 | Yes |
| cmake | 3.18.4 | apt | x86 | N/A |
| make | 4.3 | apt | x86 | N/A |

## Tooling available for `J-QMU-1`

The tools available for `J-QMU-1` is for use on RISC-V architecture and these tools do not support execution on x86 architecture

| Tool | Versions | Installed from | Host Architecture | Environment Modules Support |
| ---- | ------- | -------------- | ------------ | ------------ |
| Python3 | 3.8.15 | source | RISC-V | Yes |
| zlib | 1.2.13 | source | RISC-V | N/A |
| OpenSSL | 1.1.1r | source | RISC-V | Yes |
| Ruby (without IRB) | 3.2.0dev | source | RISC-V | Yes |
| rustc | 1.65.0 | source | RISC-V | N/A |
| Flex | 2.6.4 | source | RISC-V | yes
| Ninja | 1.12.0.git | source | RISC-V | Yes |
| Bison | 3.8.2, 2.3 | source | RISC-V | Yes |
| clang | 16.0.0 | source | RISC-V (cross compiler) | Yes |
| riscv-pk | 1.0.0-91-g573c858 | source | RISC-V | Yes |

## QEMU User mode and RISC-V GNU Cross compilers

From now on RISC-V cross-compilers can only be loaded with their respective QEMU User mode on Cloud-V. This is configured so that there is no confusion between toolchain version and qemu user mode being used because both of these will be "generally" taken from the latest releases of nightly builds. Loading a certain RISC-V toolchain using environment modules will automatically load the respective qemu usermode version unless otherwise specified.

The loading pattern for RISC-V 64-bit GNU Glibc toolchain will be as follows:

```shell
module load riscv64-gnu-glibc/<release-date>
```

And the loading pattern for RISC-V 64-bit GNU Glibc toolchain will be as follows:

```shell
module load riscv64-gnu-elf/<release-date>
```

Following table provides relevant information about version of the toolchain and the respective QEMU User mode version (where the release date is mentioned in pattern `MMDDYYYY`).

| Release date | GNU Toolchain version (elf and glibc) | QEMU Version |
| ---- | ------- | -------------- |
| 03012024 | 13.2.0 | 8.2.1 |
| 02022024 | 13.2.0 | 8.2.1 |
| 02022024 | 13.2.0 | 8.1.1 |

***Note:** The `J-QMU-1` and `J-x86-1` are one and the same runner. The purpose of creating two separate executors for same hardware is that `J-x86-1` is supposed to be specifically for x86 architecture whereas `J-QMU-1` is specifically for the users who want to cross compile source code for riscv64 architecture and then use qemu-usermode to execute them. Nevertheless, the tooling available for `J-x86-1` can also be used for `J-QMU-1`*
