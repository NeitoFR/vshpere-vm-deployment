# Connection var

variable "vs_server" {
    type = string
}
variable "vs_user" {
    type = string
}
variable "vs_password" {
    type = string
}

# Resource var

variable "vs_datacenter" {
    type = string
}

variable "vs_resource_pool" {
    type = string
}

variable "vs_network" {
    type = string
}

variable "vs_datastore" {
    type = string
}

# VM Var

variable "vm_count" {
    type = number   
}

variable "vm_guestId" {
    type = string
}

variable "vm_name" {
    type = string
}

variable "vm_cpus" {
    type = string
}

variable "vm_memory" {
    type = string
}

variable "disk_size" {
    type = string
}

variable "tpl_name" {
    type = string
}

# Content Lib var

variable "cl_datastore" {
    type = string
}

variable "cl_name" {
    type = string
}
