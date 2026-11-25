# SSH environments on RISC-V

Cloud-V gives you your own Linux environment on a real RISC-V board, free of
charge, for RISC-V and open-source development. You ask for it on the
Cloud-V website, you are **root** inside it, you log in with **your own SSH
key**, and it ends by itself after the time you chose.

## What you get

- **Your own container on a shared board.** Every person gets a Linux
  container on a real RISC-V board of the type they pick. It is not a whole
  board and not a virtual machine: other people work on the same board,
  each in their own container, and no environment can reach another.
- **Debian 13 (trixie) for riscv64**, running directly on the board's CPU
  and on the board's own Linux kernel. The board types and their
  specifications are listed in
  [Compute Instance Specifications](compute_instances.md); the request form
  shows which types are open right now.
- **root access.** Install whatever you need with `apt-get`. Already
  installed: `build-essential` (gcc, g++, make), `git`, `curl`, `wget`,
  `python3`, `tmux`, `vim-tiny`, `nano`, `less`, `iproute2`, `ping`,
  `procps` and `sudo`.
- **Resources (current defaults):** 2 GB of memory with no swap, 2 CPU
  cores' worth of CPU time, and up to 2,048 processes. Disk space is shared
  with the other people on the board and has no fixed quota, so please keep
  what you store reasonable.
- **Internet access**, outgoing only.
- **Time:** 7, 14 or 30 days, counted from the moment your environment is
  ready. You can extend it from your page, up to 60 days in total.

## What you need

- An **email address** you can read.
- An **SSH key pair**. If you have none: `ssh-keygen -t ed25519`. Accepted
  types: Ed25519 (recommended), RSA of at least 2048 bits, ECDSA, and
  security keys (`sk-ssh-ed25519`, `sk-ecdsa-sha2-nistp256`). You can
  register up to 5 keys.
- An **OpenSSH client** that supports `ProxyJump` (`ssh -J`): a terminal on
  Linux or macOS, or WSL or Git Bash on Windows. On Windows without WSL you
  edit two files by hand; your page shows what goes into them.
- A **network that lets you connect out to the board's SSH port.** Your page
  shows the host and port. The port is often not 22, and some company or
  university networks block such ports.
- A few sentences on **what you will use it for**, and your agreement to the
  [Acceptable Usage Policy](https://cloud-v.co/acceptable-usage-policy).

## Getting one

1. Open **[cloud-v.co/ssh-access](https://cloud-v.co/ssh-access)**, or use
   the SSH access request button on the Cloud-V website.
2. Fill in the form: your name, your email, optionally your organization and
   a link to your project, what you will use it for (20 to 1000
   characters), the board type, how long, and your SSH public key (the
   content of `~/.ssh/id_ed25519.pub`). Each board type shows how many
   places are free. Tick the Acceptable Usage Policy and press **Send
   request**.
3. Check your email for **"Confirm your Cloud-V SSH access request"**. Open
   its link, check that the key fingerprint it shows is yours
   (`ssh-keygen -lf ~/.ssh/id_ed25519.pub` prints it), and press **Confirm
   this request**. A request that is not confirmed within 48 hours is
   dropped. If you did not ask for it, press **This was not me - withdraw
   it**.
4. Wait for approval. A person at Cloud-V looks at every request, so this is
   not instant. After approval your request waits for a free place on a
   board, and then your environment is prepared, which takes a minute or
   two. While it waits or is being prepared, the page updates by itself.
5. You get the email **"Your Cloud-V SSH environment cv-3f9a2c1d is
   ready"** (with your environment's name) and your **private link**. Your
   days start now.

**Keep that email.** Its link opens your environment's page, in any browser,
for as long as the environment exists. Whoever has the link can manage your
environment, so do not share it. Lost it? Use
[Lost your link?](https://cloud-v.co/ssh-access/links): enter your email
address, and the links are sent to it again.

## Connecting

Your page has a **Connect** box.

**The first time,** paste the block from that box once into a terminal on
your own computer (Linux, macOS, WSL or Git Bash). It adds an entry for your
environment to `~/.ssh/config` and its host keys to `~/.ssh/known_hosts`. On
Windows without WSL, open **Edit the two files by hand instead** on the page.

**Every time:**

```bash
ssh cv-3f9a2c1d
```

You are root in your environment. The page also shows a one-line command
that works without the pasted block, of this form:

```bash
ssh -o HostKeyAlias=cv-3f9a2c1d -J cloudv-jump@<host>:<port> root@<address>
```

How it works: your connection first reaches the board's SSH port as
`cloudv-jump`. That account has no shell on the board; it can only pass your
connection on to your own environment, and only for the keys you registered.

**Copying files** works through the same name:

```bash
scp results.tar.gz cv-3f9a2c1d:
scp cv-3f9a2c1d:results.tar.gz .
sftp cv-3f9a2c1d
```

For `rsync`, install it inside first: `apt-get install rsync`.

**A web app or notebook inside your environment:** forward its port over
SSH, then open `http://localhost:8888` on your own computer:

```bash
ssh -L 8888:localhost:8888 cv-3f9a2c1d
```

**Editors:** Microsoft's VS Code Remote - SSH does not support riscv64
machines. Use [VSCodium](https://vscodium.com/) with the **Open Remote -
SSH** extension (by jeanp413) and pick `cv-3f9a2c1d` from your SSH config.
`vim` and `nano` are installed inside.

**If it does not connect:**

- Your key is not in the default place: run `ssh-add ~/.ssh/<your key>`
  first.
- `ssh -v cv-3f9a2c1d` shows where the connection stops.
- It hangs or times out: the network you are on may block the board's port.
  Try another network, or write to us.

**"Too many authentication failures":** your ssh offered many other keys
first (for example from an agent) and was stopped before it reached the
right one. Tell it which key to use. Add these two lines to the block you
pasted:

```
  IdentityFile ~/.ssh/<your key>
  IdentitiesOnly yes
```

and these three once at the end of `~/.ssh/config`, for the hop through the
board:

```
Match user cloudv-jump
  IdentityFile ~/.ssh/<your key>
  IdentitiesOnly yes
```

## Managing your environment

Everything is on your page, the link in your email:

- **Time:** the end date, and **Extend** by 7, 14 or 30 days, up to 60 days
  in total. About 24 hours before the end you get a reminder email.
- **SSH keys:** the fingerprints of the keys that get in, and **Replace
  keys** to change them (up to 5; what you paste replaces all of them). New
  keys usually work within a minute or two; until then the old ones still
  work. If you remove a key, your open sessions end at that moment. Keys you
  add to `~/.ssh/authorized_keys` inside the environment do
  not get you in from outside: add them on your page.
- **Release:** deletes the environment with every file in it. This cannot be
  undone.

**At the end date** the environment is deleted with everything in it, and
you get an email. You can ask for a new one at any time: it gets a new name
and a new link, and you confirm your email and wait for approval again.

**Several environments:** you can have 2 at the same time, of different
board types. Each has its own link; "Lost your link?" sends all of them. For
a board type you already have, you can ask again only once the old
environment has ended or you released it, so copy your work to your own
computer first.

## What you can do

- Be root: install packages (`apt-get update` first), change any file, run
  any program.
- Build, test and benchmark software natively on RISC-V: compilers, Python,
  your own toolchains.
- Use the internet: package mirrors, `git` over HTTPS or SSH, downloads.
- Keep long jobs running while you are disconnected: start them in `tmux`
  or with `nohup`.
- Run servers for yourself and reach them with `ssh -L`.

## What you cannot do

Your environment is an **unprivileged container**. You are root inside it,
but that root has no power over the board or over anybody else's
environment. In practice:

| You cannot | Why, and what to do instead |
|---|---|
| Run **Docker**, Podman or any other container engine inside | A container engine needs privileges (mounting file systems, creating namespaces and control groups, changing the firewall) that would also open the board and everybody else's environment. Docker works in Cloud-V's GitHub runners: see [Using Docker in your jobs](setting_up_github_runner.md#using-docker-in-your-jobs). |
| Use **systemd** (`systemctl`) | Only the SSH server is started. Start your own services by hand, for example in `tmux`. |
| Get onto the **board itself**, use its **hardware** (GPU, NPU, GPIO, serial, USB) or load **kernel modules** | Your environment has no hardware devices and runs on the board's kernel, which it cannot change. It also cannot reboot, change kernel settings (`sysctl`), set the clock or mount file systems. |
| Use **perf** or other tools that read hardware performance counters | They are not available inside the container. |
| Send **raw network packets** | Tools that build their own packets do not work, and `ping` may not work either. Use `curl` to test a connection. |
| Accept **incoming connections** | Your environment has no public address and no open ports. Reach your own services with `ssh -L` (see above). |
| Reach **private networks**, the board or **other environments**, or send **mail** | Connections to 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 169.254.0.0/16 and 100.64.0.0/10, and to ports 25, 465 and 587, are blocked: they hang until they time out. There is no IPv6. |
| Use more than your **share** | Past the memory limit, processes are killed (there is no swap). `free`, `top` and `nproc` show the whole board, not your share: use `make -j2`, not `make -j$(nproc)`. |
| **Keep** anything after the end date | Everything is deleted at the end date, or when you release the environment, and nothing is backed up. Copy your work out in time. |
| Keep a session open through **a key change or a restart** | When you remove one of your keys, your open sessions end: reconnect with a key that is still registered. Work you started in `tmux` or with `nohup` keeps running. Programs stop when the board or its Docker restarts; your files stay. |
| Keep **secrets** you cannot afford to lose | Environments are well separated, but they share the board's kernel. Do not store important private keys or tokens there. |

Software in your environment is not updated for you. You are root, so run
`apt-get update && apt-get upgrade` whenever you want updates.

Use it for RISC-V development, as the
[Acceptable Usage Policy](https://cloud-v.co/acceptable-usage-policy) says
(for example, no crypto mining).

## Getting help

Write to **cloud-v@10xengineers.ai** and mention your environment's name
(such as `cv-3f9a2c1d`), or ask on
[Discord](https://discord.gg/H7EGrzV93p).

If the request form does not work for you, or you need something it does
not offer (a whole board, more time, other hardware), use the
[contact form](https://cloud-v.co/contact) and choose **Direct SSH Access**.
We get back to you by email.
