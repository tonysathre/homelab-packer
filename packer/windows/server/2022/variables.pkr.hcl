# Windows Server 2022

variable "image_type" {
  type = string
}

variable "image_index" {
  type = number
}

variable "os_version" {
  type = string
}

variable "boot_wait" {
  type    = string
  default = "1s"
}

variable "insecure_connection" {
    type    = bool
    default = true
}

variable "vcenter_server" {
  type = string
}

variable "vcenter_username" {
  type      = string
  sensitive = true
}

variable "vcenter_password" {
  type      = string
  sensitive = true
}

variable "winrm_username" {
  type      = string
  sensitive = true
}

variable "winrm_password" {
  type      = string
  sensitive = true
}

variable "local_admin_username" {
  type      = string
  sensitive = true
}

variable "local_admin_password" {
  type      = string
  sensitive = true
}

variable "datacenter" {
    type = string
}

variable "cluster" {
    type = string
}

variable "datastore" {
    type = string
}

variable iso_path {
  type = string
}

variable "disk_size" {
  type    = string
  default = "20480"
}

variable "RAM" {
  type    = string
  default = "1024"
}

variable "CPUs" {
  type    = string
  default = "2"
}

variable "vm_name_prefix" {
  type    = string
  default = "win-server"
}

variable "network" {
  type    = string
  default = "VM Network"
}

variable "folder" {
  type    = string
  default = "Templates"
}

variable "product_key" {
  type = string
}