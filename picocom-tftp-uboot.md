Here's how to start a picocom terminal (Get out of it with C-a C-x)

```
picocom tty.usbserial-11220 -b 115200
```

Hit any key to stop autoboot with U-Boot

See these instructions on how to set up the TFTP server and get the image file for boot on the target device: https://community.arm.com/oss-platforms/w/docs/495/tftp-remote-network-kernel-using-u-boot

Boot script to put on U-Boot (The `boot.scr` should go in `/boot`), save this as `boot.cmd`:
```
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
```
sudo mkimage -A riscv -O linux -T script -C none -a 0 -e 0 -n "Distro Boot Script" -d boot.cmd boot.scr
```
