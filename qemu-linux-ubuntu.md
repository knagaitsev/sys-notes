## Setup

This guide for QEMU setup of Linux kernel with Ubuntu host is very useful: https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md

## Resize .img

If you need to resize the `.img` file, do so using `resize2fs`: https://linux.die.net/man/8/resize2fs

For example, to shrink to smallest size:

```
resize2fs -M file.img
```

To increase the virtual size after shrinking, without increasing the actual `.img` file size:

```
resize2fs file.img 100G
```

## Kernel Modules

If you need a kernel module in the VM, build it on the host machine using the same Linux source that you used to build the kernel. Then transfer the `.ko` file into the VM.

## Bare Metal

When it comes time to test on bare metal, the first thing to do is to install Ubuntu on the machine, and then get the kernel version you were developing with using mainline: https://sleeplessbeastie.eu/2021/11/01/how-to-install-mainline-linux-kernel-on-ubuntu-based-distribution/

This allows us to then grab the config file from the correct kernel version via:

```
cp /lib/modules/`uname -r`/build/.config .
```

Then we can build our modified Linux kernel with this working config
