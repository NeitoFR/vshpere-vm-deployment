### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
 {
  vm_ips = "${flatten(vsphere_virtual_machine.vm.*.guest_ip_addresses[*][0])}"
 }
 )
 filename = "../ansible/inventory"
}

output "vm_ips" {
    value = "${flatten(vsphere_virtual_machine.vm.*.guest_ip_addresses[*][0])}"
}