# Specifications of compute instances in Cloud-V

This document contains the specifications of the compute instances available for users to run builds in Cloud-V. The term "Compute Instance", can also be safely interchanged with the terms "Build Executor" and "Runner".

| Name String | Architecture | ISA String | Cores | Memory | Compute Instance Type |
| ---- | ------- | -------------- | ------------ | ------------------ | ---- |
| J-x86-1 (or) J-QMU-1 | x86_64 | N/A | 4 | 8GiB | Hardware with application-level emulator |
| J-TESTVM-1 | x86_64 | N/A | 4 | 8GiB | Hardware |
| J-RASP4-1 | aarch64 | ARMv8-A | 4 | 4GiB | Hardware |
| J-QMS-1 | riscv64 | See Ext 1 at bottom | 2 | 2GiB | QEMU System emulator |
| J-VF1-1 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| J-VF1-2 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| J-VF1-3 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| J-VF2-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-VF2-2 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-VF2-3 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-VF2-4 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-VF2-5 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-VF2-6 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-HF-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| J-K230-1 | riscv64 | rv64imafdcvxthead | 1 | 512MiB | Hardware |
| J-K230-1 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 1 | 512MiB | Hardware |

***Ext1:** rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zba_zbb_zbs_sstc*

***Note:** The `J-QMU-1` and `J-x86-1` are one and the same runner. The purpose of creating two separate executors for same hardware is that `J-x86-1` is supposed to be specifically for x86 architecture whereas `J-QMU-1` is specifically for the users who want to cross compile source code for riscv64 architecture and then use qemu-usermode to execute them. Nevertheless, the tooling available for `J-x86-1` can also be used for `J-QMU-1`*
