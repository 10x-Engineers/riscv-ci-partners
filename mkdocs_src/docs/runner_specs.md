# Specifications of compute instances in Cloud-V

This document contains the specifications of the compute instances available for users to run builds in Cloud-V. The term "Compute Instance", can also be safely interchanged with the terms "Build Executor" and "Runner".

| Name String | Architecture | Cores | Memory | Compute Instance Type |
| ---- | ------- | -------------- | ------------ | ------------------ |
| J-VM-1 (or) J-QMU-1 | x86_64 | 4 | 8GiB | Hardware with application-level emulator |
| J-TESTVM-1 | x86_64 | 4 | 8GiB | Hardware |
| J-RASP4-1 | aarch64 | 4 | 4GiB | Hardware |
| J-QMS-1 | riscv64 | 2 | 2GiB | QEMU System emulator |
| J-VF1-1 | riscv64 | 2 | 8GiB | Hardware |
| J-VF1-2 | riscv64 | 2 | 8GiB | Hardware |
| J-VF1-3 | riscv64 | 2 | 8GiB | Hardware |
| J-VF2-1 | riscv64 | 4 | 8GiB | Hardware |
| J-VF2-2 | riscv64 | 4 | 8GiB | Hardware |
| J-VF2-3 | riscv64 | 4 | 8GiB | Hardware |
| J-VF2-4 | riscv64 | 4 | 8GiB | Hardware |
| J-VF2-5 | riscv64 | 4 | 8GiB | Hardware |
| J-VF2-6 | riscv64 | 4 | 8GiB | Hardware |
| J-HF-1 | riscv64 | 4 | 8GiB | Hardware |

***Note:** The qemuusermode_runner1 and x86_runner1 are one and the same runner. The purpose of creating two separate executors for same hardware is that `J-VM-1` is supposed to be specifically for x86 architecture whereas `J-QMU-1` is specifically for the users who want to cross compile source code for riscv64 architecture and then use qemu-usermode to execute them. Nevertheless, the tooling available for `J-VM-1` can also be used for `J-QMU-1`*
