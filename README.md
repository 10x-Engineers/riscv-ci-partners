# riscv-ci-partners documentation

This repository contains the source code for documentation of Cloud-V project hosted through GitHub pages.

If you landed here in search for free CI runners for your GitHub or GitLab for your repository, visit [this page](https://cloud-v.co/risc-v-cicd).

## Quick Start For Software Developers
[Developer Quick Start Guide Link](https://10x-engineers.github.io/riscv-ci-partners/Software_Developer_Guide/#pre-requisites)

## Full Documentation
[Link to main documentation page](https://10x-engineers.github.io/riscv-ci-partners/)

## Building and deploying the docs

The source is `mkdocs_src/docs/` (Markdown) with `mkdocs_src/mkdocs.yml` as config. On every push to `main`, GitHub Actions (`.github/workflows/docs.yml`) builds the site and deploys it to GitHub Pages; PRs that touch `mkdocs_src/` get a build check. Built HTML is never committed.

Local preview:

```sh
pip install -r mkdocs_src/requirements.txt
cd mkdocs_src && mkdocs serve
```

Do not run `mkdocs gh-deploy` or commit a `site/` / `docs/` build folder.
