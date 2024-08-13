A few notes on using QEMU with ARM before wiping the machine (not entirely sure on the logic of everything done here):

```bash
qemu-system-aarch64 \
        -machine virt,gic-version=3 \
				-cpu cortex-a57 \
        -m 16G \
        -smp 4 \
        -kernel linux/arch/arm64/boot/Image \
        -append "console=ttyAMA0 root=/dev/vda oops=panic panic_on_warn=1 panic=-1 ftrace_dump_on_oops=orig_cpu debug earlyprintk=serial slub_debug=UZ nokaslr" \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
				-hda buildroot-2023.05.2/output/images/rootfs.ext3 \
        -net nic,model=e1000 \
        -nographic \
        -pidfile vm.pid \
        2>&1 | tee vm.log

# -enable-kvm \
# -s -S \
#
#				-drive file=image/bullseye.img,format=raw \
```

beandip arm experiment kernel can be found here: https://github.com/knagaitsev/linux/tree/beandip_arm_exp1

fetch `buildroot-2023.05.2.tar.xz` from here: https://buildroot.org/downloads/
