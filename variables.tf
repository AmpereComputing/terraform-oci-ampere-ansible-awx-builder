# User/Tenant authentication variables
variable "tenancy_ocid" {
    description = "OCI Tenancy ID for Free-Tier Account"
}

variable "user_ocid" {
    description = "OCI User ID for Free-Tier Account"
}
variable "fingerprint" {
    description = "OCI Fingerprint ID for Free-Tier Account"
}

variable "private_key_path" {
    description = "Local path to the OCI private key file"
}

# Network Configuration Variables

variable "oci_vcn_cidr_block" {
    default     = "10.1.0.0/16"
    description = "CIDR Address Block for OCI Networks"
}

variable "oci_vcn_cidr_subnet" {
    default     = "10.1.1.0/24"
    description = "CIDR Subnet Address for OCI Networks"
}

# Virtual Machine Configuration Variables

variable "instance_prefix" {
  description = "Name prefix for vm instances"
  default = "ansible-awx-builder"
}

# OCI Free Tier Ampere A1 provides 4 cores and  24G of memory.
# This can be broken up between up to 4 virtual machines.
#  * 1 vm 24G 4 cores
#  * 2 vm 16G 2 cores
#  * 4 vm 8G 1 cores

variable "oci_vm_count" {
  description = "OCI Free Tier Ampere A1 is two instances"
  default = 1
}

variable "ampere_a1_vm_memory" {
    default = "24"
    description = "Default RAM in GB for Ampere A1 instances in OCI Free Tier"
    type    = string
}

variable "ampere_a1_cpu_core_count" {
    default = "4"
    description = "Default core count for Ampere A1 instances in OCI Free Tier"
    type    = string
}
# AWX Variables
variable "awx_build_prefix" {
  default     = "ampere"
  description = "Build prefix for AWX container images"
  type        = string
}
variable "awx_version" {
  default     = "19.3.0"
  description = "Version of AWX to build/install"
  type        = string
}
variable "awx_operator_version" {
  default     = "0.14.0"
  description = "Version of AWX-Operator to build/install"
  type        = string
}
variable "docker_compose_version" {
  default     = "2.1.1"
  description = "Version of AWX-Operator to build/install"
  type        = string
}
