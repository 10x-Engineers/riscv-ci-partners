# Running CI/CD pipelines on RISC-V with Cloud-V

This document describes how someone can integrate their CI/CD projects on RISC-V compute machine.


## Supported CI/CD platforms on Cloud-V

There is a [dedicated page](https://cloud-v.co/risc-v-cicd) on Cloud-V website where you can check which version control platforms or CI/CD services are supported by Cloud-V with RISC-V compute machines. Developers can use these compute machines free of cost. 

## Supported compute machine types

Cloud-V offers vendor-agnostic physical compute machines as well as emulated compute instances. 

Physical compute machines are the SBCs, desktop computers or laptops with RISC-V SoCs in them while the emulated compute instances are running on the x86 host machines. The emulated RISC-V machines use [QEMU](https://www.qemu.org/).

See [Compute Instances in Cloud-V](compute_instances.md) for a complete list of devices available in cloud.

