### How to bind LUKS unlock to TPM2 PCRs:

Confirm TPM2

```
cat /sys/class/tpm/tpm0/device/description
sudo dmesg | grep tpm2
```

Set up with clevis, see more details here: https://wiki.archlinux.org/title/Clevis#Bind_a_LUKS_volume

```
sudo apt install clevis clevis-luks clevis-tpm2 clevis-initramfs

sudo clevis luks bind -d /dev/nvme0n1p3 tpm2 '{"pcr_bank":"sha256","pcr_ids":"0,1,7"}'

# prints slot info
sudo systemd-cryptenroll /dev/nvme0n1p3

# dumps more info
sudo cryptsetup luksDump /dev/nvme0n1p3

sudo update-initramfs -u -k all
```

To view and change clevis config:

```
sudo clevis luks list -d /dev/nvme0n1p3
sudo clevis luks unbind -d /dev/nvme0n1p3 -s <entry-number>
```

### Updates

If there is an update to kernel versions in the boot partition, when the crypt is not currently unlocked:

```bash
sudo cryptsetup luksOpen /dev/nvme0n1p3 crypt
sudo update-grub
```

If something changes in the firmware or boot setup, do the following to tie to the new PCR values:

**Note: in this example `nvme0n1p3` has been moved to `nvme1n1p3` (different SSD slot)

```
sudo clevis luks list -d /dev/nvme1n1p3
sudo clevis luks unbind -d /dev/nvme1n1p3 -s <entry-number>

# Rebind with the new PCR values
sudo clevis luks bind -d /dev/nvme1n1p3 tpm2 '{"pcr_bank":"sha256","pcr_ids":"0,1,7"}'

# Rebuild initramfs
sudo update-initramfs -u -k all
```

