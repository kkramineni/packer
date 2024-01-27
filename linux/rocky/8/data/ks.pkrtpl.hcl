#version=RHEL8
# Use graphical install
graphical

repo --name="Minimal" --baseurl=file:///run/install/sources/mount-0000-cdrom/Minimal

%packages
@^minimal-environment
kexec-tools

%end

# Keyboard layouts
keyboard --xlayouts='gb'
# System language
lang en_GB.UTF-8

# Network information
network  --bootproto=dhcp --device=ens33 --ipv6=disabled --activate
network  --hostname=rocky8.cloudbricks.local

# Use CDROM installation media
cdrom

# Run the Setup Agent on first boot
firstboot --enable

ignoredisk --only-use=sda
# Partition clearing information
clearpart --none --initlabel
part /boot --fstype xfs --size=1024 --label=BOOTFS
part /boot/efi --fstype vfat --size=1024 --label=EFIFS
part pv.01 --size=100 --grow

### Create a logical volume management (LVM) group.
volgroup sysvg --pesize=4096 pv.01

### Modify logical volume sizes for the virtual machine hardware.
### Create logical volumes.
logvol swap --fstype swap --name=lv_swap --vgname=sysvg --size=1024 --label=SWAPFS
logvol / --fstype xfs --name=lv_root --vgname=sysvg --size=12288 --label=ROOTFS
logvol /home --fstype xfs --name=lv_home --vgname=sysvg --size=4096 --label=HOMEFS --fsoptions="nodev,nosuid"
logvol /opt --fstype xfs --name=lv_opt --vgname=sysvg --size=2048 --label=OPTFS --fsoptions="nodev"
logvol /tmp --fstype xfs --name=lv_tmp --vgname=sysvg --size=4096 --label=TMPFS --fsoptions="nodev,noexec,nosuid"
logvol /var --fstype xfs --name=lv_var --vgname=sysvg --size=4096 --label=VARFS --fsoptions="nodev"
logvol /var/log --fstype xfs --name=lv_log --vgname=sysvg --size=4096 --label=LOGFS --fsoptions="nodev,noexec,nosuid"
logvol /var/log/audit --fstype xfs --name=lv_audit --vgname=sysvg --size=4096 --label=AUDITFS --fsoptions="nodev,noexec,nosuid"

# System timezone
timezone Europe/London --isUtc --nontp

# Root password
rootpw --iscrypted $6$x3xHqfCtY7cb.5Zr$/BIDj1zRJj4.2JBxfWOVmpgeeezJaNnfqv1/XQJ4pM3lVv0yXHlThnjLo9Easo1quc609I7tkVOtEs3G7KiVK.

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

reboot --eject