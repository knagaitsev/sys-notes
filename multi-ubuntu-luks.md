### Scenario

I initially installed Ubuntu with LVM+LUKS on 2 TB disk, had it take up 1.6 TB. Ran Ubuntu installer again as I wanted another separate OS at the remaining 0.4 TB of the disk (no LUKS+LVM for this one).

After installing the new Ubuntu at the end of the disk, I can only boot into the new one.

My lsblk for the disk looks like this:
- 1 GB partition (/boot/efi)
- 2 GB partition
- 1.6 TB partition
- 0.4 TB partition

### Fix

On the new OS, run the following:

```
sudo apt update
sudo apt install cryptsetup lvm2 os-prober

sudo cryptsetup luksOpen /dev/nvme0n1p3 oldcrypt

sudo os-prober

sudo vgchange -ay

sudo nano /etc/default/grub
```

Uncomment line:

```
GRUB_DISABLE_OS_PROBER=false
```

Finally run:

```
sudo update-grub
```

Should see output similar to:

```
Found Ubuntu 24.04 on /dev/mapper/oldcrypt-root
```
