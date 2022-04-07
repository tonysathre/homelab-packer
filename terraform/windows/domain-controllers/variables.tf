variable "vsphere_server" {
  type = string
}

variable "vsphere_user" {
  type      = string
  sensitive = true
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_compute_cluster" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "template_name" {
  type = string
}

variable "num_cpus" {
  type = number
}

variable "memory" {
  type = number
}

variable "firmware" {
  type = string
}

variable "guest_id" {
  type = string
}

variable "hostname" {
  type = string
}

variable "workgroup" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "time_zone" {
  type = number
}

variable "admin_password" {
  type = string
}

variable "ipv4_range" {
  type = list
}

variable "ipv4_netmask" {
  type = number
}

variable "ipv4_gateway" {
  type = string
}

variable "dns_server_list" {
  type = list(any)
}

variable "dns_domain" {
  type = string
}
