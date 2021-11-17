# Output the private and public IPs of the instance

output "Ampere_Ansible_AWX_Builder_PrivateIPs" {
  value = ["${oci_core_instance.ampere_a1.*.private_ip}"]
}

output "Ampere_Ansible_AWX_Builder_PublicIPs" {
  value = ["${oci_core_instance.ampere_a1.*.public_ip}"]
}

# Output the boot volume IDs of the instance
output "Ampere_Ansible_AWX_Builder_BootVolumeIDs" {
  value = ["${oci_core_instance.ampere_a1.*.boot_volume_id}"]
}
