# L3Out must be created locally on APIC
data "aci_l3_domain_profile" "core_s1" {
  provider = aci.site1
  name     = "core_l3dom"
}

module "l3out_wan_s1" {
  source = "github.com/adealdag/terraform-aci-l3out"
  providers = {
    aci = aci.site1
  }

  name        = var.l3out_name
  alias       = ""
  description = "L3Out to wan network"
  tenant_dn   = "uni/tn-${mso_tenant.demo.name}"
  vrf_dn      = "uni/tn-${mso_tenant.demo.name}/ctx-${mso_schema_template_vrf.prod.name}"
  l3dom_dn    = data.aci_l3_domain_profile.core_s1.id

  ospf = {
    enabled   = true
    area_id   = "0.0.0.1"
    area_type = "regular"
    area_cost = "1"
    # area_ctrl ommited, takes default value
  }

  nodes = {
    "1101" = {
      pod_id             = "1"
      node_id            = "1101"
      router_id          = "1.1.1.101"
      router_id_loopback = "no"
    },
    "1102" = {
      pod_id             = "1"
      node_id            = "1102"
      router_id          = "1.1.1.102"
      router_id_loopback = "no"
    }
  }

  interfaces = {
    "1101_1_25" = {
      l2_port_type     = "port"
      l3_port_type     = "sub-interface"
      pod_id           = "1"
      node_a_id        = "1101"
      interface_id     = "eth1/25"
      ip_addr_a        = "172.16.25.10/30"
      vlan_encap       = "vlan-25"
      vlan_encap_scope = "local"
      mode             = "regular"
      mtu              = "9216"

      ospf_interface_policy_dn = null
    },
    "1102_1_25" = {
      l2_port_type     = "port"
      l3_port_type     = "sub-interface"
      pod_id           = "1"
      node_a_id        = "1102"
      interface_id     = "eth1/25"
      ip_addr_a        = "172.16.25.14/30"
      vlan_encap       = "vlan-25"
      vlan_encap_scope = "local"
      mode             = "regular"
      mtu              = "9216"

      ospf_interface_policy_dn = null
    }
  }

  external_l3epg = {}
}
