# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

# AlmaLinux OS 9

### Installs from the first attached CD-ROM/DVD on the system.
cdrom

### Performs the kickstart installation in text mode. 
### By default, kickstart installations are performed in graphical mode.
text

### Accepts the End User License Agreement.
eula --agreed


# Keyboard layouts
keyboard --xlayouts='gb'
# System language
lang en_GB.UTF-8

### Configure network information for target system and activate network devices in the installer environment (optional)
### --onboot	  enable device at a boot time
### --device	  device to be activated and / or configured with the network command
### --bootproto	  method to obtain networking configuration for device (default dhcp)
### --noipv6	  disable IPv6 on this device
###
### network  --bootproto=static --ip=172.16.11.200 --netmask=255.255.255.0 --gateway=172.16.11.200 --nameserver=172.16.11.4 --hostname centos-linux-8
network --bootproto=dhcp

### Lock the root account.
rootpw --iscrypted --allow-ssh $6$f10cpjmfQjn8vdWA$2AxHqJT5AQYBk5y/PIoKvQCU5IoYWbbTlO3OA9jYB1/lzxov9bAM416wwlOog7IK94sZpxghG8IOkxZkysAXy.

### The selected profile will restrict root login.
### Add a user that can login and escalate privileges.
user --name=kishore --iscrypted --password=$6$f10cpjmfQjn8vdWA$2AxHqJT5AQYBk5y/PIoKvQCU5IoYWbbTlO3OA9jYB1/lzxov9bAM416wwlOog7IK94sZpxghG8IOkxZkysAXy. --groups=wheel

### Configure firewall settings for the system.
### --enabled	reject incoming connections that are not in response to outbound requests
### --ssh		allow sshd service through the firewall
firewall --enabled --ssh

### Sets up the authentication options for the system.
### The SSDD profile sets sha512 to hash passwords. Passwords are shadowed by default
### See the manual page for authselect-profile for a complete list of possible options.
authselect select sssd

### Sets the state of SELinux on the installed system.
### Defaults to enforcing.
selinux --permissive

### Sets the system time zone.
timezone Europe/London --utc

### Sets how the boot loader should be installed.
bootloader --location=mbr

### Initialize any invalid partition tables found on disks.
zerombr

### Removes partitions from the system, prior to creation of new partitions. 
### By default, no partitions are removed.
### --linux	erases all Linux partitions.
### --initlabel Initializes a disk (or disks) by creating a default disk label for all disks in their respective architecture.
clearpart --all --initlabel

part /boot/efi --fstype="efi" --ondisk=sda --size=600 --fsoptions="umask=0077,shortname=winnt"
part pv.111 --fstype="lvmpv" --ondisk=sda --size=305574
part /boot --fstype="xfs" --ondisk=sda --size=1024
volgroup rl --pesize=4096 pv.111
logvol swap --fstype="swap" --size=4045 --name=swap --vgname=rl
logvol /home --fstype="xfs" --size=40960 --name=home --vgname=rl
logvol / --fstype="xfs" --size=260564 --name=root --vgname=rl


### Modifies the default set of services that will run under the default runlevel.
services --enabled=NetworkManager,sshd

### Do not configure X on the installed system.
skipx

### Packages selection.
%packages --ignoremissing --excludedocs
@^minimal-environment
-iwl*firmware
%end

### Post-installation commands.
%post
dnf makecache
dnf install epel-release -y
dnf makecache
dnf install -y sudo open-vm-tools perl
echo "kishore ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kishore
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end

### Reboot after the installation is complete.
### --eject attempt to eject the media before rebooting.
reboot --eject
