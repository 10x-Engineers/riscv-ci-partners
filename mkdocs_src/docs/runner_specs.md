# Specifications of compute instances in Cloud-V

This document contains the specifications of the compute instances available for users to run builds in Cloud-V. The term "Compute Instance", can also be safely interchanged with the terms "Build Executor" and "Runner".

| Name| CI Name String | Architecture | ISA String | Cores | Memory | Compute Instance Type |
| ---- | ---- | ------- | -------------- | ------------ | ------------------ | ---- |
| N/A   | J-x86-1 (or) J-QMU-1 | x86_64 | N/A | 4 | 8GiB | Hardware with application-level emulator |
| intel i7-6500U| J-TESTVM-1 | x86_64 | N/A | 4 | 8GiB | Hardware |
| Raspberry Pi 4 Model B | J-RASP4-1 | aarch64 | ARMv8-A | 4 | 4GiB | Hardware |
<<<<<<< HEAD
| QEMU System Linux   | J-QMS-1 | riscv64 | See Ext 1 at bottom | 12 | 6GiB | QEMU System emulator |
| VisionFive 1   | J-VF1-1 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 1   | J-VF1-2 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 1   | J-VF1-3 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-2 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-3 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-4 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-5 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | J-VF2-6 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| HiFive Unleashed    | J-HF-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| Banana Pi F3  | J-BPF3-1 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 8 | 4GiB | Hardware |
| Banana Pi F3  | J-BPF3-2 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 8 | 16GiB | Hardware |
| Banana Pi F3  | J-BPF3-3 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 8 | 16GiB | Hardware |
| Banana Pi F3  | J-BPF3-4 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 8 | 16GiB | Hardware |
| Banana Pi F3  | J-BPF3-5 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 8 | 16GiB | Hardware |
| Milk-V Jupiter  | J-JUPITER-1 | riscv64 | rv64imafdcv<br>_sscofpmf<br>_sstcc<br>_svpbmt<br>_zicbom<br>_zicboz<br>_zicbop<br>_zihintpause | 8 | 16GiB | Hardware |
| Milk-V Pioneer Box  | J-pioneer-1 | riscv64 | rv64imafdc<br>_zicntr<br>_zicsr<br>_zifencei<br>_zihpm<br>_xtheadvector | 64 | 8GiB | Hardware |
=======
| QEMU System Linux   | J-QMS-1 | riscv64 | See at the bottom | 12 | 6GiB | QEMU System emulator |
| VisionFive 1   | sf1-1 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 1   | sf1-2 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 1   | sf1-3 | riscv64 | rv64imafdc | 2 | 8GiB | Hardware |
| VisionFive 2   | sf2-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | sf2-2 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | sf2-3 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | sf2-4 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | sf2-5 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| VisionFive 2   | sf2-6 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| HiFive Unleashed    | unleashed1-1 | riscv64 | rv64imafdc | 4 | 8GiB | Hardware |
| Banana Pi F3  | BPF3-4G-1 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 1 | 4GiB | Hardware |
| Banana Pi F3  | BPF3-16G-1 | riscv64 | rv64imafdcv<br>_sscofpmf_sstc<br>_svpbmt_zicbom<br>_zicboz_zicbop<br>_zihintpause | 1 | 4GiB | Hardware |
| Milk-V Jupiter  | jupiter-16G-1 | riscv64 | rv64imafdcv<br>_sscofpmf<br>_sstc<br>_svpbmt<br>_zicbom<br>_zicboz<br>_zicbop<br>_zihintpause | 1 | 16GiB | Hardware |
| Milk-V Jupiter  | jupiter-16G-2 | riscv64 | rv64imafdcv<br>_sscofpmf<br>_sstc<br>_svpbmt<br>_zicbom<br>_zicboz<br>_zicbop<br>_zihintpause | 1 | 16GiB | Hardware |
| Milk-V Pioneer Box  | pioneer-128G-1 | riscv64 | rv64imafdcv<br>_sscofpmf<br>_sstc<br>_svpbmt<br>_zicbom<br>_zicboz<br>_zicbop<br>_zihintpause | 4 | 8GiB | Hardware |

## QEMU Specifications:

**QEMU Version:** 10.0.0  
**QEMU OS:** Ubuntu 24.04 LTS  
**QEMU specifications:** 12 cores, 6 GB memory  
**QEMU ISA String:**   

```
rv64imafdch_zicbom_zicboz_zicntr_zicond_zicsr_zifencei_zihintntl_zihintpause_zihpm_zacas_zfa_zfh_zfhmin_zba_zbb_zbc_zbkb_zbkc_zbkx_zbs_zknd_zkne_zknh_zkr_zkt_zksed_zksh_ztso_zvbb_zvbc_zvfh_zvfhmin_zvkb_zvkg_zvkned_zvknha_zvknhb_zvksed_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
```
>>>>>>> c1be17c (Changed docs according to new format)


***Note:** The `J-QMU-1` and `J-x86-1` are one and the same runner. The purpose of creating two separate executors for same hardware is that `J-x86-1` is supposed to be specifically for x86 architecture whereas `J-QMU-1` is specifically for the users who want to cross compile source code for riscv64 architecture and then use qemu-usermode to execute them. Nevertheless, the tooling available for `J-x86-1` can also be used for `J-QMU-1`*


<div style="display: flex; align-items: flex-start; gap: 2rem;">

<div style="flex: 2;">
  <h2>My Content Title</h2>
  <p>
    This is the main content on the left side. You can include text, lists, code blocks, and more.
  </p>
</div>

<div style="flex: 1;">
  <img src="img/my-image.png" alt="My image" style="max-width: 100%; border-radius: 8px;">
</div>

</div>

