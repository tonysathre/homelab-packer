# Ubuntu Server 20.04 LTS

locals {
  data_source_content = {
    "/meta-data" = file("${abspath(path.root)}/data/meta-data")
    "/user-data" = templatefile("${abspath(path.root)}/data/user-data.pkrtpl.hcl", {
      ssh_username           = var.ssh_username
      ssh_password_encrypted = var.ssh_password_encrypted
      ssh_key                = var.ssh_key
      hostname               = var.hostname
    })
  }
  data_source_command = "ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\""
}

source "vsphere-iso" "linux-ubuntu-server" {
  # Boot Configuration
  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz --- autoinstall ${local.data_source_command}",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_wait  = var.boot_wait
  boot_order = "disk,cdrom"

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
  vm_name              = "ubuntu-server-20.04"
  guest_os_type        = "ubuntu64Guest"
  CPUs                 = var.CPUs
  cpu_cores            = var.CPUs
  RAM                  = var.RAM
  firmware             = "efi-secure"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }

  # CD Configuration
  iso_paths    = ["[${var.datastore}] ISO/ubuntu-20.04.4-live-server-amd64.iso", "[] /vmimages/tools-isoimages/linux.iso"]
  remove_cdrom = true

  # Communicator Configuration
  communicator = "ssh"
  ssh_port     = 22
  ssh_timeout  = "30m"
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password

  # Shutdown Configuration
  shutdown_timeout    = "15m"
  shutdown_command    = "sudo -E shutdown -P now"
  convert_to_template = true

  # HTTP Configuration
  http_ip        = var.http_ip
  http_content   = local.data_source_content
}

build {
  sources = ["source.vsphere-iso.linux-ubuntu-server"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install git -y",
      "sudo apt-get install ansible -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get autoremove -y",
      "sudo apt-get clean -y"
    ]
  }

  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts = [
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-logfiles.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-tmp-files.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-cloud-init.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-machine-id.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-package-manager-cache.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-package-manager-db.sh",
      "${abspath(path.cwd)}/scripts/linux/sysprep-op-bash-history.sh"
    ]
  }
}