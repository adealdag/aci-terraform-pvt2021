# Cisco ACI provider variables
variable "aci_url_site1" {
  description = "URL for CISCO APIC on Site 1"
}

variable "aci_url_site2" {
  description = "URL for CISCO APIC on Site 2"
}

variable "aci_username" {
  description = "This is the Cisco APIC username, which is required to authenticate with CISCO APIC"
  default     = "terraform"
}

variable "aci_password" {
  description = "Password of the user mentioned in username argument. It is required when you want to use token-based authentication."
  sensitive   = true
}

# Cisco MSO provider variables
variable "mso_url" {
  description = "URL for CISCO MSO/NDO"
}

variable "mso_username" {
  description = "This is the Cisco MSO/NDO username, which is required to authenticate with CISCO MSO/NDO"
  default     = "terraform"
}

variable "mso_password" {
  description = "Password of the user mentioned in username argument."
  sensitive   = true
}

# VMware vSphere provider variables

variable "vsphere_server_site1" {
  description = "IP address or FQDN of the vCenter server in Site 1"
}

variable "vsphere_server_site2" {
  description = "IP address or FQDN of the vCenter server in Site 2"
}

variable "vsphere_username" {
  description = "vCenter username"
  default     = "administrator@vsphere.local"
}

variable "vsphere_password" {
  description = "vCenter password"
  sensitive   = true
}