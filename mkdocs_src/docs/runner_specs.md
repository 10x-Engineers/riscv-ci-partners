# Specifications of compute instances in Cloud-V

This document contains the specifications of the compute instances available for users to run builds in Cloud-V. The term "Compute Instance", can also be safely interchanged with the terms "Build Executor" and "Runner".

| Name String | Architecture | Cores | Memory | Compute Instance Type |
| ---- | ------- | -------------- | ------------ | ------------------ |
| x86_runner1 (or) qemuusermode_runner1 | x86_64 | 4 | 8GiB | Hardware with application-level emulator |
| x86_runner2 | x86_64 | 1 | 512MiB | Hardware |
| dell5559 | x86_64 | 4 | 8GiB | Hardware |
| rasp4-1 | aarch64 | 4 | 4GiB | Hardware |
| riscv64_runner1 | riscv64 | 2 | 2GiB | QEMU System emulator |
| sf1-1 | riscv64 | 2 | 8GiB | Hardware |
| sf1-2 | riscv64 | 2 | 8GiB | Hardware |
| sf1-3 | riscv64 | 2 | 8GiB | Hardware |
| sf2-1 | riscv64 | 4 | 8GiB | Hardware |
| sf2-2 | riscv64 | 4 | 8GiB | Hardware |
| sf2-3 | riscv64 | 4 | 8GiB | Hardware |
| sf2-4 | riscv64 | 4 | 8GiB | Hardware |
| sf2-5 | riscv64 | 4 | 8GiB | Hardware |
| unleashed1-1 | riscv64 | 4 | 8GiB | Hardware |
| unleashed1-2 | riscv64 | 4 | 8GiB | Hardware |

***Note:** The qemuusermode_runner1 and x86_runner1 are one and the same runner. The purpose of creating two separate executors for same hardware is that `x86_runner1` is supposed to be specifically for x86 architecture whereas `qemuusermode_runner1` is specifically for the users who want to cross compile source code for riscv64 architecture and then use qemu-usermode to execute them. Nevertheless, the tooling available for `x86_runner1` can also be used for `qemuusermode_runner1`*
