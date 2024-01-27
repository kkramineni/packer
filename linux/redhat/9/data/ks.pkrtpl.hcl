# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

# Red Hat Enterprise Linux Server 9

### Installs from the first attached CD-ROM/DVD on the system.
cdrom

### Performs the kickstart installation in text mode. 
### By default, kickstart installations are performed in graphical mode.
text

### Accepts the End User License Agreement.
eula --agreed

### Sets the language to use during installation and the default language to use on the installed system.
lang en_GB.UTF-8

### Sets the default keyboard type for the system.
keyboard --xlayouts='gb'

### Configure network information for target system and activate network devices in the installer environment (optional)
### --onboot	  enable device at a boot time
### --device	  device to be activated and / or configured with the network command
### --bootproto	  method to obtain networking configuration for device (default dhcp)
### --noipv6	  disable IPv6 on this device
###
### network  --bootproto=static --ip=172.16.11.200 --netmask=255.255.255.0 --gateway=172.16.11.200 --nameserver=172.16.11.4 --hostname centos-linux-8
network --bootproto=dhcp --activate
 
### Lock the root account.
rootpw --iscrypted --allow-ssh $6$0kmeGt3OJDXliRtj$fodoF58H4bkNckAII0BMoX/G5u4TTec5hyhJD0WbNF7EUfQTVlC.pbGZ48S1JoMm1UqP1YcJZ3ets2LbmqVSA/

### The selected profile will restrict root login.
### Add a user that can login and escalate privileges.
user --name=kishore --password=VMware1! --groups=wheel

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
selinux --disabled

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

### Modify partition sizes for the virtual machine hardware.
### Create primary system partitions.
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=sda --size=1024
part pv.111 --fstype="lvmpv" --ondisk=sda --size=407974
part /boot/efi --fstype="efi" --ondisk=sda --size=600 --fsoptions="umask=0077,shortname=winnt"
volgroup rhel --pesize=4096 pv.111
logvol swap --fstype="swap" --size=8071 --name=swap --vgname=rhel
logvol /home --fstype="xfs" --size=20000 --name=home --vgname=rhel
logvol /tmp --fstype="xfs" --size=20000 --name=tmp --vgname=rhel
logvol / --fstype="xfs" --size=358940 --name=root --vgname=rhel

### Modifies the default set of services that will run under the default runlevel.
services --enabled=NetworkManager,sshd

### Do not configure X on the installed system.
skipx

### Packages selection.
%packages --ignoremissing --excludedocs
@core
-iwl*firmware
%end

### Post-installation commands.
%post

dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf makecache
dnf install -y sudo open-vm-tools perl
echo "kishore ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kishore
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end

### Reboot after the installation is complete.
### --eject attempt to eject the media before rebooting.
reboot --eject
