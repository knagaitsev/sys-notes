Start by doing:

```bash
sudo vim /etc/default/grub
```

Then if you want to select item 2 of submenu 1 (both 0-indexed), set:
```
GRUB_DEFAULT="1>2"
```

Also, if you want to make sure the grub menu displays, set:

```
# GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=20
```

Finally, run:
```bash
sudo update-grub
```
