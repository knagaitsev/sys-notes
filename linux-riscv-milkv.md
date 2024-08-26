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

scripts/config --disable RISCV_ISA_V
scripts/config --enable CMDLINE_FORCE

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make olddefconfig

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make -j48

cd ..

scp -r linux-riscv pecorino:/home/kir/linux-riscv
```

Or compiling with clang LTO:

(Note that the vendor Linux repository will not work with Clang LTO since LTO was introduced for RISC-V in Linux 6.9)

```bash
git clone git@github.com:milkv-pioneer/linux-riscv.git --depth 1 linux-riscv
```

See: https://www.phoronix.com/news/RISC-V-With-Clang-LTO-Linux-6.9

```bash
git clone git@github.com:knagaitsev/linux.git --branch sg2042-lto --depth 1 linux-riscv

cd linux-riscv

cp path/to/config-6.1.31 .config

scripts/config --disable SECURITY_LOCKDOWN_LSM
scripts/config --disable MODULE_SIG
scripts/config --disable MODULE_SIG_FORMAT
scripts/config --disable MODULE_SIG_ALL
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --disable CONFIG_DEBUG_INFO_BTF

scripts/config -e LTO_CLANG
scripts/config -e LTO_CLANG_FULL
scripts/config -d LTO_CLANG_NONE
scripts/config -d LTO_NONE

scripts/config --disable VECTOR
scripts/config --disable DRM_SMI

scripts/config --disable DYNAMIC_FTRACE

scripts/config -e CMDLINE_FORCE
scripts/config --set-str CMDLINE "console=ttyS0,115200 root=/dev/nvme0n1p3 rootfstype=ext4 rootwait rw earlycon selinux=0 LANG=en_US.UTF-8"

scripts/config --disable MODULES
scripts/config --disable KUNIT

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- LLVM=1 make olddefconfig

ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- LLVM=1 make -j48

#if it is a static build just move Image and System.map
scp arch/riscv/boot/Image pecorino:/home/kir/linux-riscv/static-image
scp System.map pecorino:/home/kir/linux-riscv/static-image
ssh pecorino "/sbin/installkernel 6.1.22+ /home/kir/linux-riscv/static-image/Image /home/kir/linux-riscv/static-image/System.map /boot"

# otherwise do the following:
cd ..

scp -r linux-riscv pecorino:/home/kir/linux-riscv

# alternatively use rsync:
rsync -avz --delete --progress linux-riscv pecorino:/home/kir/linux-riscv
```

Then on the RISC-V machine do:

```bash
cd linux-riscv
sudo make modules_install -j64
sudo make install -j64
```

Or when built statically you can simply do this:

```
/sbin/installkernel 6.1.22+ /home/kir/linux-riscv/static-image/Image /home/kir/linux-riscv/static-image/System.map /boot
```
