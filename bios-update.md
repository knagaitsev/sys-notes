Check for BIOS update here: https://www.gigabyte.com/Motherboard/B850-GAMING-WIFI6-rev-1x/support#Support-Bios

Format disk on macos:

```
diskutil list
diskutil unmountDisk /dev/disk4
sudo diskutil eraseDisk FAT32 bios-b850 MBRFormat /dev/disk4
```

Then:

- Place the file `B850GAMINGWF6.Fxx` on the USB stick.
- Plug into the desktop and start up BIOS by pressing Del.
- Run the Q-Flash utility to flash new BIOS
- Ignore BitLocker warning (BitLocker is a built-in Windows security feature that encrypts your entire drive)
- Note the Checksum from the BIOS page, it will show at end of installation
