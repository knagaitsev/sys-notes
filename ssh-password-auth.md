How to turn off password authentication:

```
sudo vim /etc/ssh/sshd_config
```

Set:
```
PasswordAuthentication no
```

Then finally do:
```
sudo service sshd restart
sudo service sshd status
```
