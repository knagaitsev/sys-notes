Here's how to start a picocom terminal (Get out of it with C-a C-x)

```bash
picocom tty.usbserial-11220 -b 115200
```

Hit any key to stop autoboot with U-Boot

See these instructions on how to set up the TFTP server and get the image file for boot on the target device: https://community.arm.com/oss-platforms/w/docs/495/tftp-remote-network-kernel-using-u-boot

## SiFive HiFive FU740

Boot script to put on U-Boot (The `boot.scr` should go in `/boot`), save this as `boot.cmd`:
```bash
setenv ipaddr <machine ip>
setenv serverip <tftp server ip>

setenv loadaddr 0x80300000
setenv fdt_addr 0x80800000

ext2load mmc 0:3 ${fdt_addr} /boot/<dtb file>
fdt addr ${fdt_addr}

tftp ${loadaddr} <img filename>

bootm ${loadaddr} - ${fdt_addr}
```

Turn it into a boot script (`boot.scr`):
```bash
sudo mkimage -A riscv -O linux -T script -C none -a 0 -e 0 -n "Distro Boot Script" -d boot.cmd boot.scr
```

## StarFive VisionFive 2

```bash
setenv ipaddr <machine ip>
setenv serverip <server ip>

setenv loadaddr 0x80300000
setenv fdt_addr 0x88000000

tftpboot ${loadaddr} ${serverip}:sifive.img

tftpboot ${fdt_addr} ${serverip}:jh7110-visionfive-v2.dtb

bootm ${loadaddr} - ${fdt_addr}
```

Put this on the machine:
```bash
sudo mkimage -A riscv -O linux -T script -C none -a 0 -e 0 -n "Distro Boot Script" -d boot.cmd boot.scr
scp boot.scr host:~ && ssh host "sudo cp ~/boot.scr /boot"
```

To ensure this script runs, rather than booting Linux, get into the U-Boot terminal and do the following:

```bash
setenv origbootcmd "$bootcmd"
setenv bootcmd "run distro_bootcmd"
saveenv
```

To print env info you can do:
```
printenv
```

If you want to boot original Linux from the microSD just run these commands instead from U-Boot:
```
run load_distro_uenv
run distro_bootcmd
```

(You could also just run `boot` for the 2nd command)
