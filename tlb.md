## Some notes on TLB shootdowns and other IPIs

Watch the TLB flush count live, making sure you have built `perf` for the kernel you are currently working with (in `linux/tools/perf`)

```bash
watch -n 1 'sudo perf stat -e tlb:tlb_flush -a -- sleep 1'
```


