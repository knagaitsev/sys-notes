To set up OpenWRT for Raspberry Pi 5, go to the firmware selector tool for RPi 5:

https://firmware-selector.openwrt.org/?version=24.10.5&target=bcm27xx%2Fbcm2712&id=rpi-5

(Note a list of other targets can be found here: https://downloads.openwrt.org/releases/24.10.5/targets/)

This assumes you have a USB ethernet dongle, where this extra ethernet port can be used as the WAN port for the RPi 5 router.

### Customize Packages

Select the dropdown to customize installed packages, then add `kmod-usb-net-rtl8152` (this is the USB dongle I have, you must adjust for the USB dongle you have)

Finally, install `Factory (Squashfs)` image and flash it to a microSD card
