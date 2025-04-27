How to turn off password authentication:

```
sudo vim /etc/ssh/sshd_config
```

Set:
```
PasswordAuthentication no
```

For Ubuntu 24.04 you may need to also update this in:

```
sudo vim /etc/ssh/sshd_config.d/50-cloud-init.conf
```

Then finally do (For Ubuntu 22.04):
```
sudo service sshd restart
sudo service sshd status
```

Or for Ubuntu 24.04:

```
sudo service ssh restart
sudo service ssh status
```
