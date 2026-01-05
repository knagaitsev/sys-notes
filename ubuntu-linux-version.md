Check what kernel would be installed right now with Ubuntu, as well as what kernel version is currently installed on the system:

```
apt policy linux-image-generic
```

Also check Linux tools version for currently installed Linux kernel:

```
apt policy linux-tools-$(uname -r)
```

Latest versions can also be checked here, according to Ubuntu version:

https://launchpad.net/ubuntu/+source/linux-meta
