// Virtual Machine Settings
common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion         = false
common_content_library_name        = "vm_library"
common_content_library_ovf         = false
common_content_library_destroy     = false
common_content_library_skip_export = false

// Removable Media Settings
common_iso_datastore = "OS_ISO"

// Boot and Provisioning Settings
common_data_source       = "http"
common_http_ip           = null
common_http_port_min     = 8000
common_http_port_max     = 8099
common_ip_wait_timeout   = "20m"
common_ip_settle_timeout = "5s"
common_shutdown_timeout  = "15m"


