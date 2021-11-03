terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "~> 0.7.0"
    }
  }
  required_version = ">= 0.13"
}
