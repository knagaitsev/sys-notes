Start out by installing and building gem5: https://www.gem5.org/documentation/general_docs/building

If you need to do a full system simulation to run some benchmarks with pthreads, openmp, etc. you will probably need to use KVM to accelerate the kernel boot portion

See: https://www.gem5.org/documentation/gem5-stdlib/x86-full-system-tutorial

This may require the following:
```
sudo chmod 666 /dev/kvm
```

You will probably also have to set the value in `/proc/sys/kernel/perf_event_paranoid` to `1`

Run Parsec like this: https://github.com/gem5/gem5/blob/stable/configs/example/gem5_library/x86-parsec-benchmarks.py

If you ever encounter an issue like `FileLockException: Timeout occured.` it can be resolved by removing the lockfiles that are present in `~/.cache/gem5`, as the simulator typically locks the kernel and benchmark files when doing a run, meaning if you kill it while it is holding the lock, subsequent runs of the simulator will fail with that error.
