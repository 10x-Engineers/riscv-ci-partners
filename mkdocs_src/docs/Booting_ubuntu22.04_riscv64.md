# Booting RISC-V Ubuntu 22.04 on `qemu-system-riscv64`  

## Pre-requisites  

Following are the pre-requisites which are needed to be installed before booting ubuntu 22.04 for RISC-V on `qemu`.  

_**Note:** Make sure RISC-V GNU Toolchain is installed before proceeding_

1. U-boot
2. Qemu version 7.0 or greater with networking  
3. Ubuntu 22.04 pre-built image for RISC-V

### 1. Installing U-boot  

_**Note:** If you plan on installing U-boot from apt or some system repository, install the one which comes with ubuntu 22.04. Older will not work with this process. Also, be sure to checkout a latest Stable version instead of development version._  

- Get source code of u-boot and checkout stable version using commands below.  

```shell
git clone https://github.com/qemu/u-boot.git
cd u-boot
git checkout v2022.10
```  

- Generate configurations for supervisor mode with following command.  

```shell
make qemu-riscv64_smode_defconfig CROSS_COMPILE=riscv64-unknown-linux-gnu-
```  

- Execute following command to start build process.  

```shell
make CROSS_COMPILE=riscv64-unknown-linux-gnu-
```

- This should install `u-boot.bin` in the source directory. This file will be used later so its path must be kept remember. Here it will be refered to as `$UBOOTPATH`.

### 2. Installing Qemu  

Qemu version 7.0 or greater should be installed with networking for ubuntu 22.04 to work. See [Installing Qemu for RISC-V](Building_qemu.md) for instructions on installing `qemu-system-riscv64`.  

### 3. Getting Ubuntu 22.04 pre-build image for RISC-V

Ubuntu 22.04 image can be downloaded from <https://ubuntu.com/download/risc-v>.  

## Booting Ubuntu 22.04 Image on qemu  

In the directory where ubuntu 22.04 image is present, execute following command to boot into ubuntu 22.04 with `qemu-system-riscv64`.  

If you need more space, you can use following command.  

```shell
qemu-img resize -f raw ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img +5G
```  

This will increase storage size of the image by 5GB.  

```shell
qemu-system-riscv64 \
-machine virt -nographic -m 2048 -smp 4 \
-kernel $UBOOTPATH/u-boot.bin \
-device virtio-net-device,netdev=eth0 -netdev user,id=eth0,hostfwd=::<host_port>-:<VM_port> \
-drive file=ubuntu-22.04.1-preinstalled-server-riscv64+unmatched.img,format=raw,if=virtio
```  

Here `-m` is the memory in Megabytes and `-smp` is number of cores. `-nographic` means qemu will use same terminal instance instead of opening a new window of its own (which is beneficial while running servers without gui). Whereas `hostfwd=::<host_port>-:<VM_port>` will forward traffic going to port `<host_port>` to port `VM_port`. Due to this port `<host_port>` will be used to access ssh on qemu machine.  

This should boot ubuntu 22.04. But it will take a while on first start.  

On start, credentials will be as follows.  

```shell
Username: ubuntu
Password: ubuntu
```

After entering credentials, terminal will prompt for change of password after which ubuntu will be ready to use.
