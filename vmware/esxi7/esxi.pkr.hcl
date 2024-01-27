//  BLOCK: packer config


packer {
  required_version = ">= 1.9.4"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.2.1"
    }
    
  }
}

//  BLOCK: data
//  Defines the data sources

//  BLOCK: locals
//  Defines the local variables.

locals {
  iso_paths         = ["[${var.common_iso_datastore}] ${var.iso_path}/${var.iso_file}"]
  vm_name             = "${var.vm_guest_os_name}${var.vm_guest_os_version}"
 
}

//  BLOCK: source
//  Defines the builder configuration blocks.

source "vsphere-iso" "esxi7" {

 
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  
  datacenter                     = var.vsphere_datacenter
  cluster                        = var.vsphere_cluster
  host                           = var.vsphere_host
  datastore                      = var.vsphere_datastore
  folder                         = var.vsphere_folder
  resource_pool                  = var.vsphere_resource_pool
  set_host_for_datastore_uploads = var.vsphere_set_host_for_datastore_uploads

  // Virtual Machine Settings
  vm_name              = local.vm_name
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_count
  cpu_cores            = var.vm_cpu_cores
  NestedHV             = true
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = "21"
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy
 

  // Removable Media Settings
  iso_paths    = local.iso_paths
 
  // Boot and Provisioning Settings
  http_ip       = var.common_data_source == "http" ? var.common_http_ip : null
  http_port_min = var.common_data_source == "http" ? var.common_http_port_min : null
  http_port_max = var.common_data_source == "http" ? var.common_http_port_max : null
  boot_order    = var.vm_boot_order
  boot_wait     = var.vm_boot_wait
  http_directory = "/opt/code/packer/vmware/esxi8/data"
  boot_command  = ["<leftShift>O ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/esx-ks.cfg<enter>"]
  ip_wait_timeout   = var.common_ip_wait_timeout
  ip_settle_timeout = var.common_ip_settle_timeout
  shutdown_command  = "esxcli system settings advanced set -o /Net/FollowHardwareMac -i 1; sed -i 's#/system/uuid.*##' /etc/vmware/esx.conf; esxcli system maintenanceMode set -e true -t 0 ; esxcli system shutdown poweroff -d 10 -r 'Packer Shutdown' ; esxcli system maintenanceMode set -e false -t 0 "
  shutdown_timeout  = var.common_shutdown_timeout

  // Communicator Settings and Credentials
  communicator       = "ssh"
  ssh_proxy_host     = var.communicator_proxy_host
  ssh_proxy_port     = var.communicator_proxy_port
  ssh_proxy_username = var.communicator_proxy_username
  ssh_proxy_password = var.communicator_proxy_password
  ssh_username       = "root"
  ssh_password       = "VMware1!"
  ssh_port           = var.communicator_port
  ssh_timeout        = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = true
}

//  BLOCK: build

build {
  sources = ["source.vsphere-iso.esxi7"]
  
}
