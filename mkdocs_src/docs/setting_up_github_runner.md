# GitHub Actions on RISC-V

Cloud-V gives your GitHub repository free CI runners on physical RISC-V
boards. You install a GitHub App once, point your workflow at a board, and
push. There is no account to create, no token to paste, and nothing to renew.

## Quick start

1. Install the [Cloud-V GitHub Runners app](https://github.com/apps/cloud-v-github-runners)
   on your repository. You can pick specific repositories or all of them, and
   change the selection later from your GitHub settings.
2. Add a board label to `runs-on:` in your workflow file.
3. Push. Your first job provisions a runner on a real board, usually within a
   few minutes, and starts.

A complete workflow:

```yaml
name: RISC-V CI
on: [push, pull_request]

jobs:
  build-and-test:
    runs-on: [self-hosted, visionfive2]
    steps:
      - uses: actions/checkout@v4

      - name: Build
        run: |
          make clean
          make all

      - name: Test
        run: make test
```

## Boards and labels

Use any label from the row you want. The alternates exist so you do not have
to remember our exact spelling.

| Board | Labels | CPU | Cores | ISA |
| --- | --- | --- | --- | --- |
| StarFive VisionFive 2 | `visionfive2`, `vf2`, `vision-five-2` | JH7110 1.5 GHz | 4 | RV64GC |
| Banana Pi BPI-F3 | `banana-pi-f3`, `bpi-f3`, `banana-pi` | SpacemiT K1 1.6 GHz | 8 | RV64GC, RVV 1.0 |
| Milk-V Pioneer | `milkv-pioneer`, `pioneer`, `milk-v-pioneer` | SG2042 2.0 GHz | 64 | RV64GC, RVV 0.71 |

Full hardware details live on the
[compute instances page](https://10x-engineers.github.io/riscv-ci-partners/compute_instances/).

Be honest with yourself about speed: these boards are slower than x86 hosted
runners, and that is the point. You are testing on the real thing.

## How runners work

Every job runs in a fresh container. When your job finishes, its runner
deregisters itself and is gone, and a replacement is prepared for your
repository automatically. Nothing carries over between jobs: no leftover
files, no half-installed packages, no stale credentials. If your workflow
needs a package, install it in a step, every time:

```yaml
- name: Install dependencies
  run: |
    sudo apt update
    sudo apt install -y python3 cmake ninja-build
```

Things worth knowing about this model:

- The very first job for a repository takes a few minutes longer while the
  runner is provisioned on a board.
- Between back to back jobs there can be a short gap, usually one to three
  minutes, while the replacement runner comes up. Jobs queued during the gap
  wait and are picked up automatically.
- Each repository gets one runner per board type, and jobs for the same board
  type run one after another. Different board types are independent, so a
  repository using `visionfive2` and `banana-pi-f3` runs those jobs in
  parallel.
- Runner names look like `owner-repo-board-a1b2c3`. You will see them under
  Settings, Actions, Runners in your repository, appearing and disappearing
  as jobs run, which is normal.

## What is inside the runner

Jobs run in a container from our open source runner image,
[`cloudv10x/github-actions-riscv`](https://hub.docker.com/r/cloudv10x/github-actions-riscv),
built on Ubuntu 24.04 for riscv64. The Docker Hub page always shows the
current version, and the fleet runs a pinned tag of that image, so what you
see there is what your job gets. The image ships the usual base: gcc, make,
git, curl, sudo, and Docker.

The runner itself is the community RISC-V port of the GitHub Actions runner,
maintained at
[Cloud-V-10xE/github-runner-riscv](https://github.com/Cloud-V-10xE/github-runner-riscv).
GitHub does not officially support RISC-V runners yet, and this port is what
makes the whole thing work. It is the same port other public RISC-V CI
efforts build on.

## Using Docker in your jobs

Docker works inside your jobs without any special flags:

```yaml
- name: Run something in a container
  run: docker run --rm riscv64/debian:trixie-slim uname -m
```

Images you pull are cached on the board itself, so a pull that was slow once
is fast the next time, even though your runner is new. The boards are shared
machines, so avoid pulling enormous images you do not need.

## Checking on things

Your repository's Settings, Actions, Runners page shows the current runner
and whether it is idle or busy. Fleet wide board status is public at
[monitor.cloud-v.co](https://monitor.cloud-v.co).

## Troubleshooting

**The job sits in queued and nothing happens.** Three causes cover almost
every case. The label does not match one from the table above, so check the
spelling. The App is not installed on this particular repository, so check
your installation's repository list. Or it is the repository's first job and
provisioning is still running, so give it five minutes before worrying.

**The job between two others took longer to start.** That is the replacement
gap described above. It is expected, and the job was never lost.

**A package will not install.** RISC-V support across the package ecosystem
is still growing, and some packages have no riscv64 build yet. Building from
source usually works, and our hosted
[RISC-V package repository](https://cloud-v.co/risc-v-resources) covers some
of the common gaps.

**Something else.** Write to cloud-v@10xengineers.ai with your repository
name, the board label you used, and what you saw, or ask on our
[Discord](https://discord.gg/H7EGrzV93p). Real people read both.

## FAQ

**Can one repository use several board types?**
Yes. Each board type gets its own runner, and jobs on different board types
run in parallel.

**Can I run several jobs in parallel on the same board type?**
No. One runner per board type per repository, jobs run sequentially.

**Do packages I install stick around?**
No, and that is deliberate. Every job starts clean. Put your dependencies in
a workflow step and they will be there every time, on any runner.

**Do I need a Cloud-V account?**
No. The GitHub App installation is the whole setup.

**Is this safe to rely on for real projects?**
Yes. Projects including llama.cpp run their RISC-V CI on this service. If a
board goes down, provisioning moves to another board of the same type.

**How do I stop using it?**
Uninstall the App from the repository. Anything ours disappears on its own.

**Which boards could be added?**
More boards exist in the fleet than are listed here, and we enable them by
demand. If your project needs a specific board, email us at cloud-v@10xengineers.ai or ask on [Discord](https://discord.gg/H7EGrzV93p).