## Cross-compile with clang to RISC-V

Install `riscv-gnu-toolchain` dependencies (listed on their github)

```
sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev
```

Below are the steps for cross-compiling to riscv, and including C/C++ standard libraries

First you need a `riscv-gnu-toolchain` 

```bash
# make sure this env var is not set
unset LD_LIBRARY_PATH

# set install location (keep this set for later steps)
export RISCV_GCC_TOOLCHAIN_PATH=$HOME/riscv

git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

cd riscv-gnu-toolchain

./configure --prefix="${RISCV_GCC_TOOLCHAIN_PATH}"
# make newlib -j $(nproc)
make linux -j $(nproc)
```

### Using the toolchain in clang

Setting the following options is required:
- `--gcc-toolchain`: path to the gcc toolchain

- `--sysroot`: path to `sysroot` within the gcc toolchain

:warning: Important: the `--sysroot` and `--gcc-toolchain` options for clang will not accept `~` as part of the path, use `$HOME` instead, or use an environment variable for the location of the gcc toolchain to make things easier (like the one set earlier)

```bash
clang++ main.cpp --target=riscv64-unknown-linux-gnu -mcmodel=medany -march=rv64g -mabi=lp64d --sysroot=$RISCV_GCC_TOOLCHAIN_PATH/sysroot --gcc-toolchain=$RISCV_GCC_TOOLCHAIN_PATH -static
```

You can test it quickly with:
```bash
sudo apt install qemu-user
qemu-riscv64 a.out
```

Note that `qemu-user` will override how executables are run so that `./a.out` will also work on a non-riscv machine, despite it being a RISC-V binary

Example C++ file for reference:
```c++
#include <iostream>

int main(int argc, char** argv) {
    std::cout << "hello world\n";

    return 0;
}
```
