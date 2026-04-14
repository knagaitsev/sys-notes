VM gets internet, but can't poke at your LAN devices:

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
