# GitLab CI on RISC-V

Cloud-V gives your GitLab project free CI runners on physical RISC-V boards.
This works with projects on gitlab.com and with self-hosted GitLab servers,
and there is no Cloud-V account to create. You create a runner in your own
GitLab, hand us its token, and we run that runner on real hardware for you.

## Quick start

1. In your GitLab project, go to Settings, CI/CD, Runners, and press
   New project runner. Two choices on that screen matter:
     - Tags: either check "Run untagged jobs", which is the simplest, or
       give the runner a tag like `riscv` and remember it for step 4.
     - Everything else can stay at its defaults.
   Press Create runner and copy the token it shows. It starts with `glrt-`.
2. Open [cloud-v.co/gitlab-riscv-runner](https://cloud-v.co/gitlab-riscv-runner).
   Paste your project URL and the token, pick a board, enter your email,
   and submit.
3. The page reports progress while the runner is set up on a board, which
   takes a few minutes. When your project's Runners page shows the runner
   with a green dot, it is live.
4. Push a pipeline. If you gave the runner a tag in step 1, your jobs must
   request that tag; if you chose untagged, they need nothing special.

A minimal `.gitlab-ci.yml`:

```yaml
build-and-test:
  tags: [riscv]        # drop this line if you chose "Run untagged jobs"
  script:
    - uname -m         # prints riscv64
    - make
    - make test
```

## Boards

| Board | CPU | Cores | ISA |
| --- | --- | --- | --- |
| StarFive VisionFive 2 | JH7110 1.5 GHz | 4 | RV64GC |
| Banana Pi BPI-F3 | SpacemiT K1 1.6 GHz | 8 | RV64GC, RVV 1.0 |
| Milk-V Pioneer | SG2042 2.0 GHz | 64 | RV64GC, RVV 0.71 |

Full hardware details are on the
[compute instances page](https://10x-engineers.github.io/riscv-ci-partners/compute_instances/).
More boards exist in the fleet and get enabled by demand, so if your project
needs something specific, ask.

## How it works

The runner you created is a project runner, so it serves your project only.
Cloud-V runs it on the board you picked as a long-lived process that polls
your GitLab for work, and every job executes in a fresh Docker container on
that board, so jobs are isolated from each other and from other projects
sharing the hardware. The default job image is `riscv64/debian:trixie-slim`,
and you can use any riscv64 image instead with the ordinary `image:` keyword:

```yaml
build:
  image: riscv64/ubuntu:24.04
  script:
    - apt update && apt install -y build-essential
    - make
```

Images your jobs pull are cached on the board, so the first pull may be slow
and later ones are fast. The boards are shared machines, so be considerate
about very large images.

Runners are recycled after 30 days. When yours expires, registering a fresh
one takes the same two minutes as the first time, with a new runner and
token from step 1, since a runner token belongs to one runner for its
lifetime. You can also remove the runner yourself at any moment by deleting
it from your project's Runners page, and everything on our side cleans up.

## Self-hosted GitLab

Nothing changes. The registration form reads your GitLab server's address
from the project URL you paste, so a project at
`https://gitlab.yourcompany.com/team/project` works exactly like one on
gitlab.com. The one requirement is that your GitLab server is reachable
from the public internet, because the runner on our board has to poll it
for jobs. A GitLab that only exists inside your VPN cannot reach our
hardware, and in that case the self-managed setup at the end of this page
is your route.

## One runner per board type

Each project gets one runner per board type, and its jobs on that board run
one after another. Different board types are independent, so a project
registered on both VisionFive 2 and Banana Pi F3 runs those pipelines in
parallel. Registering the same project and board twice is refused while the
first runner is alive.

## Troubleshooting

**The runner shows in GitLab but jobs stay pending.** Almost always tags.
Either the runner was created without "Run untagged jobs" and your jobs
carry no matching `tags:` line, or the tag is misspelled. Edit the runner
in GitLab to allow untagged jobs, or add the tag to your jobs.

**The form reported failure or the runner never appeared.** Check that the
project URL is the address of the project's main page, copied from the
browser, and that the token is fresh. A `glrt-` token belongs to the runner
it was created with, so if an attempt failed, the clean retry is to delete
that runner in GitLab, create a new one, and register with the new token.

**Self-hosted GitLab and the runner never turns green.** Your server is not
reachable from the internet, or a firewall is filtering us. The runner
polls your GitLab over HTTPS, so whatever can reach your GitLab's web
interface can run CI on it.

**The runner disappeared after a month.** That is the 30 day recycle.
Register a fresh one.

**Something else.** Email cloud-v@10xengineers.ai with your project URL and
the board you picked, or ask on our
[Discord](https://discord.gg/H7EGrzV93p).

## FAQ

**Do I need a Cloud-V account?**
No. Your GitLab account and the registration form are the whole setup.

**Can several of my projects use this?**
Yes. Each project registers its own runner, since project runners belong to
one project.

**Is my code safe on shared hardware?**
Jobs run in per-job containers, and the usual shared-runner practices
apply: keep secrets in GitLab CI/CD variables, masked and protected, rather
than in the repository.

**Can I run this stack myself?**
The workflow is open source at
[riscv-gitlab-ci-infra](https://github.com/alitariq4589/riscv-gitlab-ci-infra)
if you want to provision and manage your own boards.