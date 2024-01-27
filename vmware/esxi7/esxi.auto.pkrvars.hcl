// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "esxi"
vm_guest_os_name     = "esxi"
vm_guest_os_version  = "7"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "vmkernel8Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi"
vm_cdrom_type            = "sata"
vm_cpu_count             = 2
vm_cpu_cores             = 2
vm_cpu_hot_add           = false
vm_mem_size              = 8192
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_path = "ISO"
iso_file = "esxi7_u3.iso"

// Boot Settings
vm_boot_wait  = "1s"

// Communicator Settings
communicator_port    = 22
communicator_timeout = "30m"
