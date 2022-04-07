provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = 2
  guest_id         = var.guest_id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  name             = lower("${format("${var.hostname}%s", count.index + 1)}")
  firmware         = var.firmware
  disk {
    label = "disk0"
    size  = 40
  }
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      windows_options {
        computer_name     = lower("${format("${var.hostname}%s", count.index + 1)}")
        workgroup         = var.workgroup
        admin_password    = var.admin_password
        organization_name = var.organization_name
        time_zone         = var.time_zone
      }
      network_interface {
        ipv4_address    = "${var.ipv4_range[count.index]}"
        ipv4_netmask    = var.ipv4_netmask
        dns_server_list = var.dns_server_list
        dns_domain      = var.dns_domain
      }
      ipv4_gateway = var.ipv4_gateway
    }
  }
}