# Registering GitHub Runner with Cloud-V

For registering a free GitHub actions runner on RISC-V compute machine, visit [this](https://cloud-v.co/github-riscv-runner).

After the necessary information is provided, clicking the submit button will try to register the runner. The registration can take some time. Please be patient with next page loading. 

## Important points to note

- Only one repository is supported per RISC-V machine type. For example if you have registered a GitHub repository with VisionFive 2, you cannot register the same repository again with VisionFive 2 board type
- You must wait till the next page has loaded after the registration attempt to know the status of registration
- The github action runner will expire in 90 days and can be registered again through the [same link](https://cloud-v.co/github-riscv-runner)
- The RISC-V boards are shared compute machines using podman containers to isolate the jobs (see the section [How the GitLab Runner works](#how-the-github-action-workflow-works))

### Registration Time

This is the time required by the backend workflow to register the RISC-V machine as the GitLab runner for your project. 

Depending upon the workload, network latency, and the computing power of the RISC-V machine, this can take up to **3 minutes**. While the page is loading, be patient as it takes some time to contact the runners and register them.

Once an attempt to register is finished, you will see the result accordingly on the next page.

## Supported RISC-V machines

Currently, following RISC-V machines are supported with GitLab runner workflow.

- VisionFive 2 – Multiple boards
- Milk-V Pioneer Box – Single shared compute machine

This list is not final. The infrastructure is expected to scale both in variety and quantity of supported RISC-V boards in the near future.

The QEMU-based compute instance is configured to support a wide range of ISA extensions but is relatively slower than the RISC-V hardware. So it may take a while to register the QEMU compute machine as the runner on the page.

For a detailed list of compute machines and their specifications, see [Compute Instances in Cloud‑V](compute_instances.md).

## How the GitHub Action workflow works

The flow uses Ansible to start Podman container on the RISC-V boards and registers the runner with the passed argument inside the podman container. The podman container runs all the jobs of single repository registered with it. A single RISC-V machine can have multiple podman containers, each registered with a github repository. The Dockerfile which used for setting up the RISC-V machines is available on the [GitHub Repository](https://github.com/alitariq4589/github-actions-riscv).

## Found an issue?

If you found an issue with this workflow, you can create an issue at [GitHub Repository](https://github.com/alitariq4589/github-actions-riscv) or email us directly at cloud-v@10xengineers.ai.