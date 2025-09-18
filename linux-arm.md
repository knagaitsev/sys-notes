```bash
git clone git@github.com:knagaitsev/linux.git --branch linux_5.15
cd linux
cp /boot/config-$(uname -r) .config
make menuconfig
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --disable CONFIG_DEBUG_INFO_BTF
make olddefconfig
make -j128
sudo make modules_install -j128
sudo make install -j128
```
