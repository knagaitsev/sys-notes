This info is for Ubuntu 24.04

```
id $USERNAME
```

```
sudo vim /etc/nftables.conf
```

```
table inet filter {
    chain output {
        type filter hook output priority 0; policy accept;
        meta skuid 1001 drop # replace with user UID
    }
    chain input {
        type filter hook input priority 0; policy accept;
        meta skuid 1001 drop # optional: prevents inbound too
    }
}
```

```
sudo systemctl enable nftables
sudo systemctl restart nftables
```
