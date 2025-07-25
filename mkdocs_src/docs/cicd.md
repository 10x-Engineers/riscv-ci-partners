# Running CI/CD pipelines on RISC-V with Cloud-V

This document describes how someone can integrate their CI/CD projects on RISC-V compute machine.


## Supported CI/CD platforms on Cloud-V

There is a [dedicated page](https://cloud-v.co/risc-v-ci/cd) on Cloud-V website where you can check which version control platforms or CI/CD services are supported by Cloud-V with RISC-V compute machines. At present, developers can use these compute machines free of cost. 

Services which are labeled "Coming Soon!" are in progress and will be added soon.

## Supported compute machine types

Cloud-V offers vendor-agnostic physical compute machines as well as emulated compute instances. 

Physical compute machines are the SBCs, desktop computers or laptops with RISC-V SoCs in them while the emulated compute instances are running on the x86 host machines. The emulated RISC-V machines use [QEMU](https://www.qemu.org/).

See [Compute Instances in Cloud-V](compute_instances.md) for a complete list of devices available in cloud.

### Why do we even need QEMU

Every RISC-V SoC in the market supports only a limited set of extensions. So developers don't get flexibility to test the software on the desired ISA string. With QEMU, developers can have an exhaustive list of RISC-V extensions (which do not conflict with each other).

One other advantage is that if the x86 host machine (which is running the QEMU) has good computing power (say 128 or 256 cores), then it can be leveraged by QEMU to provide a far better computing power than what can be provided by RISC-V physical boards available in the market at present.

Check [QEMU Specifications](compute_instances.md#qemu-system-riscv64) section for specifications QEMU system running in Cloud-V.

