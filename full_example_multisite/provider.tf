terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "~> 0.7.0"
    }
    mso = {
      source  = "CiscoDevNet/mso"
      version = "~> 0.3.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
}

provider "aci" {
  alias = "site1"

  username = var.aci_username
  password = var.aci_password
  url      = var.aci_url_site1
  insecure = true
}

provider "aci" {
  alias = "site2"

  username = var.aci_username
  password = var.aci_password
  url      = var.aci_url_site2
  insecure = true
}

provider "mso" {
  username = var.mso_username
  password = var.mso_password
  url      = var.mso_url
  insecure = true
  platform = "nd"
}

provider "vsphere" {
  alias                = "vc1"
  user                 = var.vsphere_username
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server_site1
  allow_unverified_ssl = true
}

provider "vsphere" {
  alias                = "vc2"
  user                 = var.vsphere_username
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server_site2
  allow_unverified_ssl = true
}