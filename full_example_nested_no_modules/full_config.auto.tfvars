tenants = {
  "prod" = {
    name = "tf_prod"

    vrfs = {
      "prod" = {
        name    = "prod_vrf"
        pref_gr = "disabled"
        vzany = {
          cons_contracts_key = []
          prov_contracts_key = []
        }
      }
    }

    bridge_domains = {
      "192_168_1_0" = {
        name                 = "192.168.1.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.1.1/24"
        scope                = ["private"]
        relation_vrf_key     = "prod"
        associated_l3outs_dn = []
      },
      "192_168_2_0" = {
        name                 = "192.168.2.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.2.1/24"
        scope                = ["private"]
        relation_vrf_key     = "prod"
        associated_l3outs_dn = []
      },
      "192_168_3_0" = {
        name                 = "192.168.3.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.3.1/24"
        scope                = ["private"]
        relation_vrf_key     = "prod"
        associated_l3outs_dn = []
      }
    }

    app_profiles = {
      "hrms" = {
        name = "hrms_app"

        epgs = {
          "hrms_web" = {
            name               = "hrms_frontend_epg"
            name_alias         = "hrms_ngnix"
            pref_gr_memb       = "exclude"
            relation_bd_key    = "192_168_1_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = ["hrms_fe_be"]
            prov_contracts_key = ["hrms_inet_fe"]
          },
          "hrms_app" = {
            name               = "hrms_backend_epg"
            name_alias         = "hrms_nodejs"
            pref_gr_memb       = "exclude"
            relation_bd_key    = "192_168_2_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = ["hrms_be_db"]
            prov_contracts_key = ["hrms_fe_be"]
          },
          "hrms_db" = {
            name               = "hrms_database_epg"
            name_alias         = "hrms_mongodb"
            pref_gr_memb       = "exclude"
            relation_bd_key    = "192_168_3_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = []
            prov_contracts_key = ["hrms_be_db"]
          }
        }
      }
    }

    contracts = {
      "hrms_fe_be" = {
        name  = "hrms_fe_be_con"
        scope = "context"
        subjects = {
          "web" = {
            name        = "web_traffic"
            filters_key = ["http", "https"]
          }
        }
      },
      "hrms_be_db" = {
        name  = "hrms_be_db_con"
        scope = "context"
        subjects = {
          "web" = {
            name        = "mongo_traffic"
            filters_key = ["mongo"]
          }
        }
      },
      "hrms_inet_fe" = {
        name  = "hrms_inet_fe_con"
        scope = "context"
        subjects = {
          "web" = {
            name        = "secure_web_traffic"
            filters_key = ["https"]
          }
        }
      }
    }

    filters = {
      "http" = {
        name = "http"
        filter_entries = {
          "http" = {
            name        = "http"
            ether_t     = "ip"
            prot        = "tcp"
            d_from_port = "http"
            d_to_port   = "http"
          }
        }
      },
      "https" = {
        name = "https"
        filter_entries = {
          "http" = {
            name        = "https"
            ether_t     = "ip"
            prot        = "tcp"
            d_from_port = "https"
            d_to_port   = "https"
          }
        }
      },
      "mongo" = {
        name = "mongo"
        filter_entries = {
          "mongo" = {
            name        = "mongo"
            ether_t     = "ip"
            prot        = "tcp"
            d_from_port = "27017"
            d_to_port   = "27017"
          }
        }
      }
    }
  },
  "dev" = {
    name = "tf_dev"

    vrfs = {
      "dev" = {
        name    = "dev_vrf"
        pref_gr = "disabled"
        vzany = {
          cons_contracts_key = []
          prov_contracts_key = []
        }
      }
    }

    bridge_domains = {
      "192_168_101_0" = {
        name                 = "192.168.101.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.101.1/24"
        scope                = ["private"]
        relation_vrf_key     = "dev"
        associated_l3outs_dn = []
      },
      "192_168_102_0" = {
        name                 = "192.168.102.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.102.1/24"
        scope                = ["private"]
        relation_vrf_key     = "dev"
        associated_l3outs_dn = []
      },
      "192_168_103_0" = {
        name                 = "192.168.103.0_24_bd"
        type                 = "L3"
        ip_addr              = "192.168.103.1/24"
        scope                = ["private"]
        relation_vrf_key     = "dev"
        associated_l3outs_dn = []
      }
    }

    app_profiles = {
      "demo" = {
        name = "demo_app"

        epgs = {
          "demo_web" = {
            name               = "demo_web_epg"
            name_alias         = ""
            pref_gr_memb       = "include"
            relation_bd_key    = "192_168_101_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = []
            prov_contracts_key = []
          },
          "demo_app" = {
            name               = "demo_app_epg"
            name_alias         = ""
            pref_gr_memb       = "include"
            relation_bd_key    = "192_168_102_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = []
            prov_contracts_key = []
          },
          "demo_db" = {
            name               = "demo_db_epg"
            name_alias         = ""
            pref_gr_memb       = "include"
            relation_bd_key    = "192_168_103_0"
            domains_dn         = ["uni/vmmp-VMware/dom-vmm_vds"]
            cons_contracts_key = []
            prov_contracts_key = []
          }
        }
      }
    }

    contracts = {}

    filters = {}
  }
}
