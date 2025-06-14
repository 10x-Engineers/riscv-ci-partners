# Adding RISC-V compute machine as GitLab Runner

This document explains how developers working on GitLab projects can add RISC-V machines provided by Cloud-V as a GitLab runners.

## Register the runner

For registering the runner, visit [this](https://cloud-v.co/gitlab-riscv-runner) link. Add the necessary information on the page and then select a compute machine to use as GitLab runner. 

After the necessary information is placed, clicking the submit button will try to register the runner. The registration can take some time so please be patient with next page loading. 

### Registration Time

This is the time required by the backend workflow to register the RISC-V machine as the GitLab runner for your project. 

Depending upon the workload, network latency, and the computing power of the RISC-V machine, this can take up to **3 minutes**. While the page is loading, be patient as it takes some time to contact the runners and register them (especially QEMU machine since it is relatively slower right now).

Once an attempt to register is finished, you will see the result accordingly on the next page.

### Initial Contact Time

This is the time GitLab server takes to contact the RISC-V machine after the registration is complete. Once the GitLab is successful in contacting the runner, you will see a solid green circle with GitLab runner on the runners page.

This time also depends on the workload and computing power of the RISC-V machine. The maximum recorded time with QEMU machine is about **5 minutes**.

Once the contact is successful, all the jobs can run as usual.

## Supported RISC-V machines

Currently, following RISC-V machines are supported with GitLab runner workflow.

- VisionFive 2 – Multiple boards
- Banana Pi F3 – Multiple boards
- QEMU System RISC-V – Single instance (supports extensive ISA extensions and offers high compute capacity)

This list is not final. The infrastructure is expected to scale both in variety and quantity of supported RISC-V machines in the near future.

The QEMU-based compute instance is configured to support a wide range of ISA extensions and benefits from powerful host compute resources. It will soon be upgraded with additional cores to further enhance performance.

For a detailed list of compute machines and their specifications, see [Compute Instances in Cloud‑V](compute_instances.md).

## How the GitLab Runner works

The GitLab runner runs on a non-sudo user on the specified RISC-V machines. Every RISC-V machine can be a shared runner between different GitLab projects. The GitLab runner package runs as docker executor on the RISC-V machine so that every job is isolated from other jobs. The necessary information about the specification of GitLab runner is mentioned on the [GitLab runner registration page](https://cloud-v.co/gitlab-riscv-runner) of Cloud-V.

Following diagram presents a view of how the job runs on the RISC-V machines in the Cloud-V.

![GitLab RISC-V Runner](<../doc_images/gitlab-riscv-working-diagram.drawio.png>) 