variable "vcenter_username" {
  type        = string
  description = "The username for authenticating to vCenter."
  default     = ""
  sensitive   = true
}

variable "vcenter_password" {
  type        = string
  description = "The plaintext password for authenticating to vCenter."
  default     = ""
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "The username to use to authenticate over SSH."
  default     = ""
  sensitive   = true
}

variable "ssh_password" {
  type        = string
  description = "The plaintext password to use to authenticate over SSH."
  default     = ""
  sensitive   = true
}

variable "ssh_password_encrypted" {
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

# vSphere Objects

variable "vcenter_insecure_connection" {
  type        = bool
  description = "If true, does not validate the vCenter server's TLS certificate."
  default     = true
}

variable "vcenter_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
  default     = ""
}

variable "datacenter" {
  type        = string
  description = "Required if there is more than one datacenter in vCenter."
  default     = ""
}

variable "datastore" {
  type        = string
  description = "Required for clusters, or if the target host has multiple datastores."
  default     = ""
}

variable "cluster" {
  type        = string
  description = "Required for clusters, or if the target host has multiple datastores."
  default     = ""
}

variable "network" {
  type        = string
  description = "The network segment or port group name to which the primary virtual network adapter will be connected."
  default     = ""
}

variable "folder" {
  type        = string
  description = "The VM folder in which the VM template will be created."
  default     = "Templates"
}

variable "hostname" {
  type    = string
  default = "ubuntu-server"
}

variable "iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for ISO images."
  default     = ""
}

variable iso_file {
  type        = string
  description = "The file name of the guest operating system ISO image installation media."
  # https://releases.ubuntu.com/20.04/ubuntu-20.04.1-live-server-amd64.iso
  default = ""
}

variable "iso_checksum" {
  type        = string
  description = "The SHA-512 checkcum of the ISO image."
  default     = ""
}

# HTTP Endpoint

variable "http_ip" {
  type = string
}

variable "http_directory" {
  type        = string
  description = "Directory of config files(user-data, meta-data)."
  default     = ""
}

# Virtual Machine Settings

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family."
  default     = ""
}

variable "vm_guest_os_vendor" {
  type        = string
  description = "The guest operating system vendor."
  default     = ""
}

variable "vm_guest_os_member" {
  type        = string
  description = "The guest operating system member."
  default     = ""
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version."
  default     = ""
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid."
  default     = ""
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'bios' or 'efi')"
  default     = ""
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type."
  default     = ""
}

variable "CPUs" {
  type        = number
  description = "The number of virtual CPUs sockets."
  default     = "1"
}

variable "cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket."
  default     = "1"
}

variable "RAM" {
  type        = number
  description = "The size for the virtual memory in MB."
  default     = "1024"
}

variable "disk_size" {
  type        = number
  description = "The size for the virtual disk in MB."
  default     = "10240"
}

variable "boot_wait" {
  type        = string
  description = "The time to wait before boot. "
  default     = "1s"
}

variable "common_data_source" {
  type        = string
  description = "The provisioning data source. (e.g. 'http' or 'disk')"
  default     = "http"
}