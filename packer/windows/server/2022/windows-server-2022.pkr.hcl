# Windows Server 2022

packer {
  required_plugins {
    windows-update = {
      version = "0.14.0"
      source = "github.com/rgl/windows-update"
    }
  }
}

locals {
  build_date = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

source "vsphere-iso" "windows-server-2022-standard-core" {
  # Boot Configuration
  boot_command = ["<spacebar>"]
  boot_wait    = var.boot_wait

  # vCenter Configuration
  insecure_connection = true
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  folder              = var.folder

  # Hardware Configuration
  vm_name              = "${var.vm_name_prefix}-${var.os_version}-${var.image_type}"
  guest_os_type        = "ubuntu64Guest"
  CPUs                 = var.CPUs
  cpu_cores            = var.CPUs
  RAM                  = var.RAM
  firmware             = "efi-secure"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }
  notes = "Built by HashiCorp Packer on: ${local.build_date}"

  # Floppy Configuration
  floppy_files = [
    "${path.cwd}/scripts/windows/"
  ]
  floppy_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/data/autounattend.pkrtpl.hcl", {
      image_index          = var.image_index
      local_admin_username = var.local_admin_username
      local_admin_password = var.local_admin_password
    })
  }

  # CD Configuration
  iso_paths    = ["[vsanDatastore] ISO/SERVER_EVAL_x64FRE_en-us.iso", "[] /vmimages/tools-isoimages/windows.iso"]
  remove_cdrom = true

  # Communicator Configuration
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "4h"
  winrm_use_ssl  = false
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password

  # Shutdown Configuration
  shutdown_timeout    = "30m"
  convert_to_template = true
}

source "vsphere-iso" "windows-server-2022-standard-gui" {
  # Boot Configuration
  boot_command = ["<spacebar>"]
  boot_wait    = var.boot_wait

  # vCenter Configuration
  insecure_connection = true
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  folder              = var.folder

  # Hardware Configuration
  vm_name              = "${var.vm_name_prefix}-${var.os_version}-${var.image_type}"
  guest_os_type        = "windows2019srvNext_64Guest"
  CPUs                 = var.CPUs
  cpu_cores            = var.CPUs
  RAM                  = var.RAM
  firmware             = "efi-secure"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }
  notes = "Built by HashiCorp Packer on: ${local.build_date}"

  # Floppy Configuration
  floppy_files = [
    "${path.cwd}/scripts/windows"
  ]
  floppy_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/data/autounattend.pkrtpl.hcl", {
      image_index          = var.image_index
      local_admin_username = var.local_admin_username
      local_admin_password = var.local_admin_password
    })
  }

  # CD Configuration
  iso_paths    = ["[vsanDatastore] ISO/SERVER_EVAL_x64FRE_en-us.iso", "[] /vmimages/tools-isoimages/windows.iso"]
  remove_cdrom = true

  # Communicator Configuration
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "4h"
  winrm_use_ssl  = false
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password

  # Shutdown Configuration
  shutdown_timeout    = "30m"
  convert_to_template = true
}

source "vsphere-iso" "windows-server-2022-datacenter-core" {
  # Boot Configuration
  boot_command = ["<spacebar>"]
  boot_wait    = var.boot_wait

  # vCenter Configuration
  insecure_connection = true
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  folder              = var.folder

  # Hardware Configuration
  vm_name              = "${var.vm_name_prefix}-${var.os_version}-${var.image_type}"
  guest_os_type        = "windows2019srvNext_64Guest"
  CPUs                 = var.CPUs
  cpu_cores            = var.CPUs
  RAM                  = var.RAM
  firmware             = "efi-secure"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }
  notes = "Built by HashiCorp Packer on: ${local.build_date}"

  # Floppy Configuration
  floppy_files = [
    "${path.cwd}/scripts/windows/"
  ]
  floppy_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/data/autounattend.pkrtpl.hcl", {
      image_index          = var.image_index
      local_admin_username = var.local_admin_username
      local_admin_password = var.local_admin_password
    })
  }

  # CD Configuration
  iso_paths    = ["[vsanDatastore] ISO/SERVER_EVAL_x64FRE_en-us.iso", "[] /vmimages/tools-isoimages/windows.iso"]
  remove_cdrom = true

  # Communicator Configuration
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "4h"
  winrm_use_ssl  = false
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password

  # Shutdown Configuration
  shutdown_timeout    = "30m"
  convert_to_template = true
}

source "vsphere-iso" "windows-server-2022-datacenter-gui" {
  # Boot Configuration
  boot_command = ["<spacebar>"]
  boot_wait    = var.boot_wait

  # vCenter Configuration
  insecure_connection = true
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  datacenter          = var.datacenter
  datastore           = var.datastore
  cluster             = var.cluster
  folder              = var.folder

  # Hardware Configuration
  vm_name              = "${var.vm_name_prefix}-${var.os_version}-${var.image_type}"
  guest_os_type        = "windows2019srvNext_64Guest"
  CPUs                 = var.CPUs
  cpu_cores            = var.CPUs
  RAM                  = var.RAM
  firmware             = "efi-secure"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }
  notes = "Built by HashiCorp Packer on: ${local.build_date}"

  # Floppy Configuration
  floppy_files = [
    "${path.cwd}/scripts/windows/"
  ]
  floppy_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/data/autounattend.pkrtpl.hcl", {
      image_index          = var.image_index
      local_admin_username = var.local_admin_username
      local_admin_password = var.local_admin_password
    })
  }

  # CD Configuration
  iso_paths    = ["[${var.datastore}] ${var.iso_path}", "[] /vmimages/tools-isoimages/windows.iso"]
  remove_cdrom = true

  # Communicator Configuration
  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "4h"
  winrm_use_ssl  = false
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password

  # Shutdown Configuration
  shutdown_timeout    = "30m"
  convert_to_template = true
}

build {
  sources = [
      "source.vsphere-iso.windows-server-2022-standard-core",
      "source.vsphere-iso.windows-server-2022-standard-gui",
      "source.vsphere-iso.windows-server-2022-datacenter-core",
      "source.vsphere-iso.windows-server-2022-datacenter-gui"
  ]

  provisioner "windows-update" {
    pause_before    = "30s"
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*VMware*'",
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
      "include:$true"
    ]
    restart_timeout = "120m"
  }

  provisioner "powershell" {
    pause_before = "30s"
    scripts      = ["scripts/windows/cleanup.ps1"]
  }
}
