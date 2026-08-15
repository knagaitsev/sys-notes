Instructions (from `~/dev/bios-b850/f10`)

- Download the BIOS file from the GIGABYTE website and unzip it to the root directory of the bootable USB flash drive
- Plug into PC and go to BIOS Q-Flash
- Verify checksum matches
- IMPORTANT: the reboot happens automatically, so you just have a moment to verify the checksum

Note the following BIOS settings that we want after a re-flash:

- Secure Boot enabled (Secure Boot Mode: standard)
- XMP profile (XMP 1)
- CSM Support: Disabled
