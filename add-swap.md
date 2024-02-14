Increase size of existing swap file:

```
sudo swapoff /swap.img

# 64G, using 1G blocks
sudo dd if=/dev/zero of=/swap.img bs=1G count=64

sudo mkswap /swap.img
sudo swapon /swap.img
```
