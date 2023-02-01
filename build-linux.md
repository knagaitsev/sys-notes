## Notes for Building Linux

Important: make sure not do just do `-j`, specificy a number of procs

```
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.91.tar.xz
tar -xf linux-5.15.91.tar.xz
cd linux-5.15.91

sudo apt-get install syslinux isolinux

make menuconfig

scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --disable CONFIG_DEBUG_INFO_BTF

make -j40
```
