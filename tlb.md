## Some notes on TLB shootdowns and other IPIs

Watch the TLB flush count live, making sure you have built `perf` for the kernel you are currently working with (in `linux/tools/perf`)

```bash
sudo mount -o remount,mode=755 /sys/kernel/tracing/
watch -n 1 'sudo perf stat -e tlb:tlb_flush -a -- sleep 1'
```

We are interested in capturing TLB shootdown events such as this one: https://github.com/knagaitsev/linux/blob/linux_5.15/arch/x86/mm/tlb.c#L877

Turn on tracing for TLB flushes (tee the value 1 into the target files as sudo):

```bash
echo 1 | sudo tee /sys/kernel/debug/tracing/events/tlb/tlb_flush/enable > /dev/null
echo 1 | sudo tee /sys/kernel/debug/tracing/tracing_on > /dev/null
```

Look at the trace:

```bash
sudo cat /sys/kernel/debug/tracing/trace > tlb.trace
```

Turn off TLB flush tracing and clear the latest trace

```bash
echo 0 | sudo tee /sys/kernel/debug/tracing/events/tlb/tlb_flush/enable > /dev/null
echo | sudo tee /sys/kernel/debug/tracing/trace > /dev/null
```
