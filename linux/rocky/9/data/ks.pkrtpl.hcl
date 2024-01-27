# Generated by Anaconda 34.25.2.10
# Generated by pykickstart v3.32
#version=RHEL9
# Use graphical install
text
repo --name="minimal" --baseurl=file:///run/install/sources/mount-0000-cdrom/minimal

%addon com_redhat_kdump --disable

%end

# Keyboard layouts
keyboard --xlayouts='gb'
# System language
lang en_GB.UTF-8

# Network information
network  --bootproto=dhcp --device=ens33 --noipv6 --activate
network  --hostname=rocky9.cloudbricks.local

# Use CDROM installation media
cdrom

%packages
@^minimal-environment

%end

# Run the Setup Agent on first boot
firstboot --enable

# Generated using Blivet version 3.6.0
ignoredisk --only-use=sda
# Partition clearing information
clearpart --none --initlabel
# Disk partitioning information
part /boot/efi --fstype="efi" --ondisk=sda --size=600 --fsoptions="umask=0077,shortname=winnt"
part pv.111 --fstype="lvmpv" --ondisk=sda --size=305574
part /boot --fstype="xfs" --ondisk=sda --size=1024
volgroup rl --pesize=4096 pv.111
logvol swap --fstype="swap" --size=4045 --name=swap --vgname=rl
logvol /home --fstype="xfs" --size=40960 --name=home --vgname=rl
logvol / --fstype="xfs" --size=260564 --name=root --vgname=rl

# System timezone
timezone Europe/London --utc

# Root password
rootpw --iscrypted --allow-ssh $6$f10cpjmfQjn8vdWA$2AxHqJT5AQYBk5y/PIoKvQCU5IoYWbbTlO3OA9jYB1/lzxov9bAM416wwlOog7IK94sZpxghG8IOkxZkysAXy.



### Post-installation commands.
%post
dnf makecache
dnf install epel-release -y
dnf makecache
dnf install -y sudo open-vm-tools perl
%end

### Reboot after the installation is complete.
### --eject attempt to eject the media before rebooting.
reboot --eject
