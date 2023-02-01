## Cross-compile with clang to RISC-V

You may need to install this dependency beforehand:

```
sudo apt install texinfo
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
qemu-riscv64 a.out
```

Example C++ file for reference:
```c++
#include <iostream>

int main(int argc, char** argv) {
    std::cout << "hello world\n";

    return 0;
}
```
