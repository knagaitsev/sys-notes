## QEMU vfio-pci GPU setup

### BIOS Settings (Gigabyte B850 Gaming Wifi 6)

- Initial Output Display -> IGD or iGPU (NOT PCIe display)
- Enable IOMMU (extra Kernel DMA settings below will show up)
- Kernel DMA Protection Indicator -> Disabled
- Pre-boot DMA Protection -> Disabled

### Host Checks

Confirm the BIOS settings are good. There should be no "direct" lines in the output of this command

```bash

cat /sys/kernel/iommu_groups/12/reserved_regions
```

Verify there is no GPU visible with `nvidia-smi` (No host driver actively using card on start):

```bash
nvidia-smi
```

Make sure there is no nvidia persistence service:

```bash
systemctl status nvidia-persistenced
```

### libvirt VM XML Setup

```bash
virsh edit agent-vm1
```

Anywhere inside `<devices>`

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source><address domain='0x0000' bus='0x01' slot='0x00' function='0x0'/></source>
</hostdev>
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source><address domain='0x0000' bus='0x01' slot='0x00' function='0x1'/></source>
</hostdev>
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source><address domain='0x0000' bus='0x01' slot='0x00' function='0x2'/></source>
</hostdev>
<hostdev mode='subsystem' type='pci' managed='yes'>
  <source><address domain='0x0000' bus='0x01' slot='0x00' function='0x3'/></source>
</hostdev>
```

Add memory locking, right after `</currentMemory>`, before `<vcpu>`:

```xml
<memoryBacking>
  <locked/>
</memoryBacking>
```

This memory locking increases OOM risk if using a high amount of memory, so decrease accordingly:

```xml
<memory unit='KiB'>100663296</memory>          <!-- 96 GiB -->
<currentMemory unit='KiB'>100663296</currentMemory>
```
