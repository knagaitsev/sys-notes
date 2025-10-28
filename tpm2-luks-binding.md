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
