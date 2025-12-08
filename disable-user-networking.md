This info is for Ubuntu 24.04

```
id $USERNAME
```

```
sudo vim /etc/nftables.conf
```

```
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
	chain input {
		type filter hook input priority filter;
		iif "lo" accept
		meta skuid 1001 drop
	}
	chain forward {
		type filter hook forward priority filter;
	}
	chain output {
		type filter hook output priority filter;
		oif "lo" accept
		meta skuid 1001 drop
	}
}
```

```
sudo systemctl enable nftables
sudo systemctl restart nftables
```
