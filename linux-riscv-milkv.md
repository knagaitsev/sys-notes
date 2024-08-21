On the build machine do

```bash
git clone git@github.com:milkv-pioneer/linux-riscv.git --depth 1 linux-riscv

cd linux-riscv

cp path/to/config-6.1.31 .config

scripts/config --disable SECURITY_LOCKDOWN_LSM
scripts/config --disable MODULE_SIG
scripts/config --disable MODULE_SIG_FORMAT
scripts/config --disable MODULE_SIG_ALL
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --disable CONFIG_DEBUG_INFO_BTF

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make olddefconfig

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make -j48

cd ..

scp -r linux-riscv pecorino:/home/kir/linux-riscv
```

Then on the RISC-V machine do:

```bash
cd linux-riscv
sudo make modules_install -j64
sudo make install
```
