# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Red Hat Enterprise Linux 9 build variables.
    Packer Plugin for VMware vSphere: 'vsphere-iso' builder.
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_name     = "rhel"
vm_guest_os_version  = "9.2"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "rhel9_64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"
vm_cdrom_type            = "sata"
vm_cpu_count             = 4
vm_cpu_cores             = 2
vm_cpu_hot_add           = false
vm_mem_size              = 8192
vm_mem_hot_add           = false
vm_disk_size             = 409600
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path = "ISO"
iso_file = "rhel-9.2-x86_64-dvd.iso"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "2s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
