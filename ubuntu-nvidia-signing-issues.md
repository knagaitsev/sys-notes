## Explanation

Sometimes unattended kernel upgrades happen on Ubuntu.

The NVIDIA module exists and is signed, but it's signed with a key (your machine's MOK) that isn't enrolled in Secure Boot's trust list, following the unattended kernel upgrade.

## Fix

Check the signer of the nvidia kernel module.

```bash
modinfo -F signer nvidia
# list enrolled keys, checking for the key from the previous command
mokutil --list-enrolled | grep <signer-name>
```

Locate public key and import it:

```bash
ls -l /var/lib/dkms/mok.pub /var/lib/shim-signed/mok/MOK.der 2>/dev/null
# import
sudo mokutil --import <public-key-path>
```

Now reboot.

On reboot you'll hit a blue MOK Manager screen (it only waits ~10 seconds — don't let it time out or it just boots normally and nothing changes). Choose Enroll MOK → Continue → Yes, enter that password, then reboot.
