To use perf do the following:

```
perf record ./mybinary
perf report
```

To use callgrind do the following:
```
valgrind --tool=callgrind ./a.out
callgrind_annotate
```

You can also set the outfile:

```
valgrind --tool=callgrind --callgrind-out-file=callgrind.out ./a.out
```

You can view it interactively with the following:

```
qcachegrind callgrind.out
```
