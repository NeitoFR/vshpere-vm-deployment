terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "1.24.2"
    }
  }
}

provider "vsphere" {
    user           = var.vs_user
    password       = var.vs_password
    vsphere_server = var.vs_server

    # If you have a self-signed cert
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vs_datacenter
}

data "vsphere_resource_pool" "pool" {
  name          = var.vs_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vs_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "cl_datastore" {
  name          = var.cl_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "content_lib" {
  name = var.cl_name
}

data "vsphere_content_library_item" "centos7_tpl" {
  name        = "centos7-docker-zsh"
  library_id  = data.vsphere_content_library.content_lib.id
  type        = "ovf"
}

data "vsphere_network" "network" {
  name          = var.vs_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
// data "vsphere_virtual_machine" "template" {
//     name = var.tpl_name
//     datacenter_id = "${data.vsphere_datacenter.dc.id}"
// }
resource "vsphere_virtual_machine" "vm" {
  count            = var.vm_count
  name             = "${var.vm_name}_${count.index+1}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  clone {
    template_uuid = data.vsphere_content_library_item.centos7_tpl.id
  }

  num_cpus = var.vm_cpus
  memory   = var.vm_memory
  guest_id = var.vm_guestId

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  
  cdrom {
    client_device = true
  }

  disk {
    label = "disk0"
    size  = 32
  }
}