## libvirt Setup

```bash
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst
```

```
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $(whoami)

# start new session, then check:

virsh list --all
```

## Create VM

```bash
sudo cp disk.qcow2 /var/lib/libvirt/images/agent-vm1.qcow2
sudo chown libvirt-qemu:kvm /var/lib/libvirt/images/agent-vm1.qcow2

virt-install --name agent-vm1 --memory 118784 --vcpus sockets=1,cores=16,threads=1 --cpu host-passthrough --os-variant ubuntu24.04 --disk path=/var/lib/libvirt/images/agent-vm1.qcow2,bus=virtio,discard=unmap --import --network network=default,model=virtio --graphics none --console pty,target_type=serial --memballoon none --rng /dev/urandom

# view or edit the XML
virsh edit agent-vm1

virsh start agent-vm1

# open shell (`Ctrl + ]` to exit)
virsh console agent-vm1

# shut down
virsh shutdown agent-vm1
```

## Network Setup

Check the IP of the new VM:

```bash
virsh domifaddr agent-vm1
```

### DHCP Issue Fix

In case an IP is not showing up, it may be due to DHCP not running on the Ubuntu VM. Follow instructions below to fix this.

(More about this issue can be found in the following conversation: https://claude.ai/chat/88b4fd6b-48e4-4305-b819-e6d04cf62ab0)

```bash
sudo ip link set enp1s0 up

sudo nano /etc/netplan/01-netcfg.yaml
```

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      dhcp4: true
```

```bash
sudo chmod 600 /etc/netplan/01-netcfg.yaml
sudo netplan apply
```

### SSH Config

Once you can obtain the VM IP, set up SSH config:

```
Host agent-vm1-kiwi-libvirt
  Hostname 192.168.122.62
  User kir
  ProxyJump kiwi
  LocalForward 24241 localhost:24241
```

## Auto-start and auto-shutdown

Edit `/etc/default/libvirt-guests`

```
# Action on host shutdown: shutdown or suspend
ON_SHUTDOWN=shutdown

# How long to wait for guests to shut down (seconds)
SHUTDOWN_TIMEOUT=300

# Action on host boot for previously running guests
ON_BOOT=start   # or 'ignore'
```

```bash
sudo systemctl enable libvirt-guests
sudo systemctl start libvirt-guests
```

Then check:

```bash
systemctl status libvirt-guests

# See which VMs are set to autostart (these are managed on boot)
virsh list --autostart
```

## Network Isolation

VM gets internet, but can't poke at your LAN devices with the following XML config. Write this to a file `no-lan-access.xml` at any location.

```xml
<filter name='no-lan-access' chain='ipv4'>
  <!-- Allow DHCP/DNS to the host bridge -->
  <rule action='accept' direction='out' priority='100'>
    <ip dstipaddr='192.168.122.1'/>
  </rule>
  <!-- Block private ranges -->
  <rule action='drop' direction='out' priority='500'>
    <ip dstipaddr='192.168.0.0' dstipmask='16'/>
  </rule>
  <rule action='drop' direction='out' priority='500'>
    <ip dstipaddr='10.0.0.0' dstipmask='8'/>
  </rule>
  <rule action='drop' direction='out' priority='500'>
    <ip dstipaddr='172.16.0.0' dstipmask='12'/>
  </rule>
  <!-- Allow everything else (internet) -->
  <rule action='accept' direction='out' priority='1000'/>
</filter>
```

Add the filter (this copies the filter file over to `/etc/libvirt/nwfilter/`):

```bash
virsh nwfilter-define no-lan-access.xml

```

It can now be viewed:

```bash
virsh nwfilter-list
```

Edit the VM config with:

```bash
virsh edit agent-vm1
```

Attach it to the VM by editing its XML (virsh edit), find the `<interface>` block, and add:

```xml
<filterref filter='no-lan-access'/>
```

Finally, shut the VM down, then start it again.
