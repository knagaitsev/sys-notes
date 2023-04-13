Start out by installing and building gem5: https://www.gem5.org/documentation/general_docs/building

If you need to do a full system simulation to run some benchmarks with pthreads, openmp, etc. you will probably need to use KVM to accelerate the kernel boot portion

See: https://www.gem5.org/documentation/gem5-stdlib/x86-full-system-tutorial

This may require the following:
```
sudo chmod 666 /dev/kvm
```

You will probably also have to set the value in `/proc/sys/kernel/perf_event_paranoid` to `1`
