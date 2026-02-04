# GitHub Runner for RISC-V - Documentation

Get free RISC-V compute machines as GitHub runners for your CI/CD workflows.

---

## Quick Start (Recommended for New Users)

Getting started is simple - just three steps:

1. **Install the GitHub App**: Go to [Cloud-V GitHub Runners](https://github.com/apps/cloud-v-github-runners) and click "Install"
2. **Select Repositories**: Choose which repositories should have access to RISC-V runners
3. **Add the Label**: In your workflow file, use `runs-on:` with one of our [supported board labels](#supported-risc-v-boards)

That's it! Your first build will automatically provision a RISC-V runner.

### Complete Workflow Example

```yaml
name: RISC-V CI
on: [push, pull_request]

jobs:
  build-and-test:
    runs-on: visionfive2  # Use a RISC-V runner
    steps:
      - uses: actions/checkout@v3
      
      - name: Build project
        run: |
          make clean
          make all
      
      - name: Run tests
        run: make test
```

---

## Choosing Your Method: App vs Legacy

| Feature | **GitHub App (Beta)** ✅ | **Legacy (Web Form)** |
|---------|-------------------------|----------------------|
| **Recommended for** | New users, production use | Special cases only |
| **Setup** | One-time app installation | Manual form submission per board |
| **Registration** | Automatic via webhook | Manual, 2-5 minutes wait |
| **After 90 days** | Auto-renews on next run | Manual re-registration required |
| **Availability** | Real-time through GitHub | Check via email/Discord |
| **Future** | Actively maintained | Will be deprecated |

**Our recommendation**: Use the GitHub App unless you have a specific reason not to.

> **Note**: The Legacy workflow will eventually be deprecated, though no timeline has been set.

---

## Supported RISC-V Boards

Add one of these labels to your workflow's `runs-on:` field:

| Label | Board | CPU | Cores | RAM | ISA Extensions | Storage |
|-------|-------|-----|-------|-----|----------------|---------|
| `visionfive2` | StarFive VisionFive 2 | JH7110 @ 1.5GHz | 4 | 2-8GB | RV64GC | 64GB SD |
| `banana-pi-f3` | Banana Pi BPI-F3 | SpacemiT K1 @ 1.2GHz | 8 | 2-16GB | RV64GC, RVV 1.0, 2.0 TOPS AI | 8-128GB eMMC |
| `milkv-pioneer` | Milk-V Pioneer Box | SG2042 @ 2.0GHz | 64 | Up to 128GB | RV64GC, RVV 0.71 | 500GB NVMe |

### Performance Expectations

RISC-V boards are currently slower than x86 GitHub-hosted runners. This is expected as the ecosystem is still maturing. For detailed benchmark comparisons, see our [performance comparison page](https://cloud-v.co/riscv-comparison).

**Key points**:
- First build takes 2-5 minutes (pulling Docker image and registration)
- Subsequent builds start at normal speed
- Build times will be longer than x86, but you're helping advance RISC-V adoption!

---

## GitHub App Setup (Beta)

### Installation

1. Visit [Cloud-V GitHub Runners App](https://github.com/apps/cloud-v-github-runners)
2. Click "Install" or "Configure" (if already installed)
3. Select "All repositories" or choose specific ones
4. Click "Install" to grant permissions

**Permissions requested**:
- Read access to metadata
- Read and write access to actions and administration

These permissions allow the app to register runners and manage GitHub Actions for your repositories.

### First Build

When you push a commit with a RISC-V label in your workflow:

1. **First time only**: 2-5 minutes to pull the Docker image and register the runner
2. GitHub shows the runner as `riscv-BOARD_TYPE-YYYYMMDD` in your repository settings
3. **All subsequent builds**: Normal startup time

### Verifying Registration

To confirm your runner is registered:

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Actions** → **Runners**
3. Look for a runner named `riscv-BOARD_TYPE-YYYYMMDD`

You can also check runner status on our [monitoring dashboard](https://monitor.cloud-v.co).

### How It Works

- **One runner per board type per repository**: If you have multiple workflows using `visionfive2`, they'll share the same runner and run sequentially
- **Docker isolation**: Each repository gets its own Docker container on the RISC-V board
- **Persistent environment**: Packages you install remain available across builds
- **Automatic renewal**: After 90 days, the runner is removed but automatically re-provisioned on your next build

---

## Legacy Setup (Web Form)

> **⚠️ Note**: This method will be deprecated in the future. We recommend using the GitHub App instead.

For the legacy workflow, visit [cloud-v.co/github-riscv-runner](https://cloud-v.co/github-riscv-runner).

### Important Limitations

- Only one board type per repository (e.g., can't register both VisionFive 2 and Banana Pi F3 for the same repo)
- Manual re-registration required after 90 days
- Registration takes 2-5 minutes - wait for the confirmation page to load
- More steps and points of failure compared to the GitHub App

---

## Pre-installed Software

The Docker container runs Ubuntu RISC-V with these packages pre-installed:

- **Build tools**: gcc, make, git
- **Core utilities**: curl, ca-certificates, sudo
- **Container runtime**: docker.io (Docker-in-Docker capability)
- **Libraries**: libatomic1, libicu-dev

**Need additional software?** Install it in your workflow:
```yaml
- name: Install dependencies
  run: |
    sudo apt update
    sudo apt install -y python3 cmake ninja-build
```

Packages remain installed for the lifetime of the container (until the 90-day renewal).

### Base Image

The container is based on the official [Ubuntu RISC-V image](https://hub.docker.com/r/riscv64/ubuntu). View the complete [Dockerfile on GitHub](https://github.com/alitariq4589/github-actions-riscv-image/blob/docker_acces/Dockerfile.ubuntu).

---

## Usage Limits & Quotas

| Limit | Value |
|-------|-------|
| **Concurrent jobs** | 1 per board type per repository |
| **Build timeout** | Standard GitHub Actions limits |
| **Storage** | 64GB (most boards), 500GB (Milk-V Pioneer) |
| **Network** | Full internet access, no restrictions |
| **Runner lifetime** | 90 days (auto-renewed in App mode) |

### Storage Management

You are responsible for cleaning up build artifacts and temporary files. The container persists between builds, so disk usage will accumulate.

**Example cleanup step**:
```yaml
- name: Cleanup
  if: always()
  run: |
    rm -rf build/
    docker system prune -f
```

---

## The 90-Day Cycle

### With GitHub App (Beta)
- After 90 days, the runner is automatically removed from the registry
- **Your next build automatically provisions a fresh runner** - no action needed
- The new runner starts with a clean environment (previously installed packages are gone)

### With Legacy Workflow
- After 90 days of registration, the runner expires
- You must manually re-register through the [web form](https://cloud-v.co/github-riscv-runner)
- Your builds won't run until you re-register

---

## Troubleshooting

### Build Not Starting

**Check if the runner is online**:
1. Go to **Settings** → **Actions** → **Runners** in your repository
2. Look for your runner (`riscv-BOARD_TYPE-YYYYMMDD`)
3. Check if it shows as "Active" or "Offline"

**Alternative**: Check the [Cloud-V monitoring dashboard](https://monitor.cloud-v.co) to see if your board type is online.

**If runner shows as offline or doesn't exist**:
- For **GitHub App**: The webhook should auto-provision. Wait 2-5 minutes and try again.
- For **Legacy**: You may need to re-register through the web form.
- If issues persist, [contact support](#need-help).

### First Build Taking Too Long

This is expected! The first build:
1. Provisions the runner (if needed)
2. Pulls the Docker image (~several hundred MB)
3. Registers with GitHub
4. Starts your workflow

**Expected time**: 2-5 minutes for first build, normal thereafter.

### Runner Becomes Unreachable

The Docker container may occasionally become corrupted due to:
- Network issues during registration
- Unexpected system events
- Storage issues

**What to do**:
1. Check if the runner appears in your repository settings
2. If it shows but GitHub can't contact it, the container may be corrupted
3. **Contact us immediately** (see [Need Help](#need-help) section)

We currently have no automated detection for corrupted containers, so your report helps us fix it quickly.

### Common Build Failures

**Package installation fails**: 
- RISC-V support is still maturing. Some packages may not have RISC-V builds yet
- Try building from source or check for RISC-V-specific repositories

**Performance issues**:
- RISC-V is currently slower than x86 - this is expected
- See our [benchmark comparisons](https://cloud-v.co/riscv-comparison)

**Docker-in-Docker issues**:
- The container supports running Docker, but nested containers may have limitations
- Use `docker run --privileged` if you encounter permission issues

---

## Advanced Topics

### GitHub Secrets

GitHub secrets work normally with Cloud-V runners. Use them as you would with any GitHub Actions workflow:

```yaml
env:
  API_KEY: ${{ secrets.MY_API_KEY }}
```

### Network Access

Runners have full internet access with no blocked ports or restrictions. You can:
- Download dependencies from public repositories
- Access external APIs
- Push to container registries
- Deploy to remote servers

### Docker-in-Docker

The container supports running Docker containers inside it. Example:

```yaml
- name: Run tests in container
  run: |
    docker run --rm ubuntu:latest bash -c "echo 'Testing in Docker'"
```

**Note**: Use `--privileged` flag if you encounter permission issues.

### Unregistering a Runner
 
- Simply uninstall the app from the repository, or
- Wait 90 days of inactivity and runner will be removed automatically

---

## Important Notes About GitHub Actions on RISC-V

### Unofficial Port

The GitHub Actions runner for RISC-V is **not officially supported by GitHub**. We're using a community port maintained at:
- [github-runner-riscv](https://github.com/alitariq4589/github-runner-riscv)

This port is actively maintained and functional, but some features may lag behind the official GitHub Actions runner.

### Limitations to Be Aware Of

1. **Storage cleanup is your responsibility** - The Docker container persists between builds
2. **One concurrent job** per board type per repository
3. **No automatic corruption detection** - Report issues if your runner becomes unreachable
4. **Performance** - RISC-V boards are slower than x86; expect longer build times

---

## Need Help?

If you encounter any issues:

### Before Contacting Support

1. Check if your runner is listed in **Settings** → **Actions** → **Runners**
2. Verify the runner shows as "Active" (green dot)
3. Check the [monitoring dashboard](https://monitor.cloud-v.co) for overall system status
4. Review the [troubleshooting section](#troubleshooting) above

### Contact Us

We're here to help! Reach out through:

- **Email**: cloud-v@10xengineers.ai
- **Discord**: Join our [RISC-V Software Ecosystem community](https://discord.gg/H7EGrzV93p)
- **Website**: [cloud-v.co](https://cloud-v.co)

We aim to respond as quickly as possible. Including the following information helps us help you faster:
- Your GitHub repository name
- Board type you're using (`visionfive2`, `banana-pi-f3`, or `milkv-pioneer`)
- Runner name from your repository settings
- Error messages or unexpected behavior you're seeing

---

## Want a Different Board?

We have additional RISC-V boards available but only enable them based on demand. 

**See all available boards**: Check the [Compute Instances page](compute_instances.md) for our complete inventory.

**Need something specific?**
- Email us at cloud-v@10xengineers.ai
- Join our [Discord community](https://discord.gg/H7EGrzV93p)
- Tell us which board you need and why

We regularly add new boards based on community interest!

---

## FAQ

### Can I use multiple board types in the same repository?
No. Each repository can only register **one board type**. However, you can use the same board type across multiple workflow files.

### What happens to my packages after 90 days?
When the runner is renewed (automatically with the App, manually with Legacy), you get a fresh Docker container. All previously installed packages are gone.

### Why is my build so slow?
RISC-V performance currently lags behind x86. This is expected as the ecosystem matures. Your contribution to testing helps drive improvements! See our [benchmark comparison](https://cloud-v.co/riscv-comparison).

### Can I run multiple jobs in parallel?
No. Only one job can run at a time per board type per repository. Multiple jobs will queue and run sequentially.

### How do I check if a board is available?
Check the [monitoring dashboard](https://monitor.cloud-v.co) or look for your runner in **Settings** → **Actions** → **Runners**.

### What if my job needs more than 64GB storage?
Most boards have 64GB. The Milk-V Pioneer has 500GB. If you need more, contact us to discuss options.

### Can I use this for production CI/CD?
Yes! The GitHub App (Beta) is stable enough for production use. Many projects are already using it successfully.

### Do I need a Cloud-V account?
No. Just install the GitHub App or fill out the Legacy form - no separate account required.



*Last updated: February 2026*