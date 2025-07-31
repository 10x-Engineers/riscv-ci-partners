# Getting Started with Linaro's LAVA on Cloud-V

This guide provides a step-by-step introduction to start using Cloud-V's LAVA lab for U-Boot/firmware testing on RISC-V boards. This is intended for software developers who want to test the firmware on RISC-V hardware boards.

## What is LAVA

LAVA (Linaro's Automated Validation Architecture) is an open-source, continuous integration system designed for automated testing of firmware (such as OpenSBI, U-Boot, Linux Kernel) on physical hardware. It allows us to:

- Run tests repeatedly and consistently on real hardware.
- View results in a web-based dashboard.
- Safely manage access to a pool of test devices.

In this lab, we've configured LAVA to test binaries on our specific RISC-V based hardware.

## Prerequisites

Before you begin, ensure you have the following:

### User Account 

A user account on our LAVA instance (where our LAVA server is hosted: https://kernelci-1.cloud-v.co) is required.

You can request an account through [this](https://cloud-v.co/contactus) page.

Admin will assign a username and password to your account.

### API Token 

Authentication tokens allow scripts using `lavacli` to securely access LAVA resources. Once a user account has been created, you need to get your token from the LAVA server.

- Go to API->Authentication Tokens
- Click on the “new” icon, add a description for this token, and click on the create button. It will create and assign a token against your username.
- Refer to [this](https://validation.linaro.org/static/docs/v2/first_steps.html#authentication-tokens) page for further details on the authentication token.

### Test Binaries

Your compiled RISC-V binaries (such as Linux Kernel, OpenSBI, U-Boot etc.) and any necessary test scripts. These are typically specific for every RISC-V board.

## Key Concepts in LAVA
- **Device:** A physical hardware board (e.g., a specific RISC-V SBC) attached to the LAVA dispatcher (worker) available in the lab
- **Device Type:** A classification for similar devices (e.g., `riscv-virt-qemu`, `banana-pi-riscv-board`)
- **Job Definition (LAVA YAML):** A YAML file that describes what to test, how to deploy it, and what device type to use
- **Bundle:** A collection of files (binaries, root filesystems, test scripts) that LAVA will deploy to the device
- **Result:** The outcome of a test job (PASS, FAIL, WAIVED, INCOMPLETE)

## Accessing the LAVA Web Interface

The Cloud-V's LAVA dashboard is hosted at https://kernelci-1.cloud-v.co.

You can access it through the provided credentials

## Preparing Your Test Binaries
Your RISC-V firmware binaries and accompanying test scripts need to be accessible to LAVA.

### Using a Public Git Repository
If your binaries/scripts are part of a public Git repository, you can specify the repository URL in your job definition. LAVA can clone it.

## Creating a LAVA Job Definition (YAML)

This is the core of telling LAVA what to do. You'll write a YAML file that describes your test.

### Example Template for RISC-V Binary Testing:

```
# LAVA Job Definition: Flash uboot-opensbi.itb via UART YMODEM


# ====================================================================
# Job Metadata
# ====================================================================


job_name: 3 - Flash of bootloader on SD card using uuu - u-boot only (health-check)
device_type: banana-pi-f3 # This must match the 'device_type' defined in your device dictionary
timeouts:
 job:
   minutes: 12 # Overall job timeout
visibility: public # Or 'private' if you prefer


# ====================================================================
# LAVA Actions
# ====================================================================
actions:
 # 1. Deploy the .itb image (LAVA downloads it to the dispatcher's temp directory)
 - deploy:
     timeout:
       minutes: 7
     to: downloads # Or 'tmpfs'. 'download' is often more explicit.
     images:
       image: # Name for the image
         url: file:///uboot-opensbi_buildroot.itb #
       uImage:
         url: https://github.com/alitariq4589/k1-kernelci-setup/blob/main/images/uImage-bianbu
       dtb:
         url: https://github.com/alitariq4589/k1-kernelci-setup/blob/main/images/k1-x_deb1_cloud_v.dtb
       ramdisk:
         url: https://github.com/alitariq4589/k1-kernelci-setup/blob/main/images/initramfs-generic.img
       rootfs:
         url: http://github.com/alitariq4589/k1-kernelci-setup/releases/tag/buildroot/rootfs.ext2
 - deploy:
     timeout:
       minutes: 10
     to: flasher # Or 'tmpfs'. 'download' is often more explicit.
     images:
       image: # Name for the boot image
         url: downloads://uboot-opensbi_buildroot.itb


 # 2. Boot the device and perform the UART YMODEM flash
 - boot:
      method: u-boot
      transfer_overlay:
         download_command: cd /tmp ; wget
         unpack_command: none
      commands:
      - "setenv ipaddr 192.168.2.5"
      - "setenv serverip 192.168.2.2"
      - "setenv netmask 255.255.255.0"
      - "setenv gatewayip 192.168.2.2"
      - "setenv dtb_addr 0x31000000"
      - "setenv ramdisk_addr 0x21000000"
      - "setenv fdt_high 0xffffffffffffffff"
      - "setenv kernel_addr_r 0x11000000"
      - "setenv rootfs_path /nfsroot/rootfs"
      - "setenv bootfs_path /nfsroot/bootfs"
      - "setenv rootpath /nfsroot/rootfs"
      - "setenv console ttyS0,115200"
      - "setenv dtb_name k1-x_deb1_cloud_v.dtb"
      - "setenv ramdisk_name initramfs-generic.img"
      - "setenv knl_name uImage-bianbu"
      - "workqueue.default_affinity_scope=system"
      - "commonargs=setenv bootargs ${console}  earlyprintk quiet splash plymouth.ignore-serial-consoles plymouth.prefer-fbcon clk_ignore_unused swiotlb=65536 workqueue.default_affinity_scope=${workqueue.default_affinity_scope}"
      - "setenv get_kernel 'echo \"Loading kernel from NFS...\"; nfs ${kernel_addr_r} ${serverip}:${bootfs_path}/${knl_name}'"
      - "setenv get_dtb 'echo \"Loading dtb from NFS...\"; nfs ${dtb_addr} ${serverip}:${bootfs_path}/${dtb_name}'"
      - "setenv get_ramdisk 'nfs ${ramdisk_addr} ${serverip}:${bootfs_path}/${ramdisk_name}; setenv ramdisk_size ${filesize}; setenv ramdisk_combo ${ramdisk_addr}:${ramdisk_size}'"
      - "setenv set_boot_args 'setenv bootargs \"${bootargs}\" root=/dev/nfs nfsroot=${serverip}:${rootfs_path} bootfs=${serverip}:${bootfs_path} rootpath=/ ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}::${netdev}:off noipath'"
      - "setenv start_kernel 'fdt addr ${dtb_addr}; if fdt list /; then bootm ${kernel_addr_r} ${ramdisk_combo} ${dtb_addr}; else booti ${kernel_addr_r} ${ramdisk_combo} ${dtb_addr}; fi;'"
      - "setenv nfs_boot 'echo \"Try to boot from NFS ...\"; run commonargs; run set_boot_args; run get_kernel; run get_dtb; run get_ramdisk; run start_kernel; echo \"########### boot kernel failed from NFS, check your boot config #############\"'"
      - "fdt addr ${dtb_addr}"
      - "run nfs_boot"
     
      auto_login:
         login_prompt: 'Bianbu login:'
         username: 'root'
         password: 'bianbu'
      prompts:
      - 'Welcome to Bianbu Linux'


      reset: false # Do not reset the device after booting
      timeout:
         minutes: 10
```

### Notes

- **device_type:** This must match a device type configured in your lab. Ask your lab admin or check the LAVA dashboard's "Device Types" section.
- **URLs:** Add the actual HTTP/HTTPS URLs to your opensbi.bin, uImage, dtb, rootfs etc. binaries

### boot section:

- **method:** This will vary based on your device. Common methods include u-boot, qemu (for QEMU virtual devices), tftp, etc. Consult your lab admin.
- **kernel_args:** Essential if you're booting a Linux kernel, especially with NFS rootfs.

## Submitting Your LAVA Job

### Using the LAVA Command-Line Client (`lavacli`)

This is ideal for automation and scripting.

#### Install LAVA CLI Tools:

Install the `lavacli` using command `sudo apt-get install lavacli`.

#### Authenticate with the LAVA Server:

Once the token is created, create an identity with that token using following command.

```
lavacli identities add --token <TOKEN> --uri https://kernelci-1.cloud-v.co/RPC2 --username <USERNAME> <identity_name>
```

#### List identities

You can list the created identities using following command.

```
lavacli identities list
```

#### Submit your jobs

Use following command to submit jobs.

```
lavacli -i <identity_name> jobs submit <job_name>
```

This command will submit the job and return a Job ID.

## Monitoring Your Job

After submission, your job will appear in the LAVA Dashboard.

- Go to the "Your Jobs" section (or the main dashboard)
- Find your job by its Job ID or your username
- Click on your job to see its details. This page provides
    - **Status:** Pending, Running, Finished, Canceled
    - **Log:** Real-time log output from the device as LAVA performs deployment, boot, and testing steps. This is crucial for debugging
    - **Results:** A summary of test cases (PASS/FAIL) reported by lava-test-case commands

## Getting Help

**LAVA Documentation:** Refer to the official [LAVA documentation](https://docs.lavasoftware.org/lava/index.html) for detailed information.

**LAVA Mailing List**

If you have questions related to the LAVA, you can post them on the [LAVA mailing list](https://lists.lavasoftware.org/mailman3/lists/).

**Email Us**

If you need help related to infrastructure feature or need to add something new, email us at cloud-v@10xengineers.ai