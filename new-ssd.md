Bad block verification:

```
sudo badblocks -wsv /dev/nvme0n1
```

Unmount the disk

```
# wipe existing partition table
sudo wipefs -a /dev/nvme0n1
# creates partition p1
sudo parted /dev/nvme0n1 --script mklabel gpt
sudo parted /dev/nvme0n1 --script mkpart primary ext4 0% 100%
# formats partition
sudo mkfs.ext4 -F /dev/nvme0n1p1
```

Test:

```
sudo nvme smart-log /dev/nvme0
sudo nvme error-log /dev/nvme0

sudo mkdir -p /mnt/ssd
sudo mount -o discard,noatime /dev/nvme0n1p1 /mnt/ssd

# seq
sudo fio --name=seq-read --directory=/mnt/ssd --rw=read --bs=1M --size=1G --iodepth=32 --ioengine=libaio --direct=1 --runtime=10 --time_based
sudo fio --name=seq-write --directory=/mnt/ssd --rw=write --bs=1M --size=1G --iodepth=32 --ioengine=libaio --direct=1 --runtime=10 --time_based
# random
sudo fio --name=rand-read --directory=/mnt/ssd --rw=randread --bs=4k --size=1G --iodepth=64 --numjobs=4 --ioengine=libaio --direct=1 --runtime=10 --time_based
sudo fio --name=rand-write --directory=/mnt/ssd --rw=randwrite --bs=4k --size=1G --iodepth=64 --numjobs=4 --ioengine=libaio --direct=1 --runtime=10 --time_based
```

Watch temp:

```
watch -n 1 "sudo smartctl -a /dev/nvme0 | grep -i temperature"
```
