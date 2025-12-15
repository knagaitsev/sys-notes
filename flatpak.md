System install:

```
flatpak install <file>.flatpak
```

User install:

```
flatpak install --user <file>.flatpak
```

Apply overrides (for system install, sudo is required):

```
sudo flatpak override --unshare=network <appid>
sudo flatpak override --unshare=ipc <appid>
```

Alternatively, use Flatseal:

```
flatpak install flathub com.github.tchx84.Flatseal
```

Show overrides:

```
flatpak override --show <appid>
```

Reset overrides:

```
sudo flatpak override --reset <appid>
```
