To move some files from limburger to `/tank`, I did the following:

```
rsync -aS /home/kir/beandip /tank/kir/limburger
```

- `-a` = archive, recurses into directories (same as `-r`), but also perserves ownership and modification times
- `-S` = ensure sparse files are handled efficiently (e.g. `.ext2` disk images which have much larger logical size)

The equivalent with cp would be to run this:

```
cp -a --sparse=always /home/kir/beandip /tank/kir/limburger
```

### Important Notes

Disk usage will be different between the source and destination, due to block size differences and the zfs filesystem on `/tank`:

```
kir@limburger:/tank$ stat -f /
  File: "/"
    ID: 3efcb58b8948f02b Namelen: 255     Type: ext2/ext3
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 114304572  Free: 28864155   Available: 23039439
Inodes: Total: 29106176   Free: 21601242
kir@limburger:/tank$ stat -f /tank
  File: "/tank"
    ID: 0        Namelen: 255     Type: nfs
Block size: 1048576    Fundamental block size: 1048576
Blocks: Total: 67172181   Free: 67172181   Available: 67172181
Inodes: Total: 137568624823 Free: 137568624721
kir@limburger:/tank$
```

**To test this:**

- transfer a larger set of files (like the Linux kernel source tree) from local disk to zfs via rsync
- use `ncdu .` to check virtual size and size on disk, for both the local disk and zfs. See size on disk has increased for zfs due to larger block sizes
- use rsync to transfer it back from zfs to the original disk, and see that the size on disk shrinks back down on local disk
- virtual sizes should match throughout
