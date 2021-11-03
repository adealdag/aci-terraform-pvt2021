locals {
  stretched_template_name = "stretched"
  site1_template_name     = "${lower(var.site1)}_only"
  site2_template_name     = "${lower(var.site2)}_only"
  templates_deploy = true
}

# Create Tenant
resource "mso_tenant" "demo" {
  name         = "ms_prod_tn"
  display_name = "ms_prod_tn"

  site_associations {
    site_id = data.mso_site.site1.id
  }

  site_associations {
    site_id = data.mso_site.site2.id
  }

  # user_associations {
  #   user_id = data.mso_user.current_user.id
  # }
}

# Schema and Templates
resource "mso_schema" "ms_prod" {
  name          = "ms_prod_schema"
  template_name = local.stretched_template_name
  tenant_id     = mso_tenant.demo.id
}

resource "mso_schema_template" "ms_prod_site1_only" {
  schema_id    = mso_schema.ms_prod.id
  name         = local.site1_template_name
  display_name = local.site1_template_name
  tenant_id    = mso_tenant.demo.id
}

resource "mso_schema_template" "ms_prod_site2_only" {
  schema_id    = mso_schema.ms_prod.id
  name         = local.site2_template_name
  display_name = local.site2_template_name
  tenant_id    = mso_tenant.demo.id
}

resource "mso_schema_site" "schema_site_1_tpl1" {
  schema_id     = mso_schema.ms_prod.id
  site_id       = data.mso_site.site1.id
  template_name = mso_schema.ms_prod.template_name
}

resource "mso_schema_site" "schema_site_1_tpl2" {
  schema_id     = mso_schema.ms_prod.id
  site_id       = data.mso_site.site1.id
  template_name = mso_schema_template.ms_prod_site1_only.id
}

resource "mso_schema_site" "schema_site_2_tpl1" {
  schema_id     = mso_schema.ms_prod.id
  site_id       = data.mso_site.site2.id
  template_name = mso_schema.ms_prod.template_name
}

resource "mso_schema_site" "schema_site_2_tpl2" {
  schema_id     = mso_schema.ms_prod.id
  site_id       = data.mso_site.site2.id
  template_name = mso_schema_template.ms_prod_site2_only.id
}

# Deploy templates
resource "mso_schema_template_deploy" "template_stretched_s1_deployer" {
  schema_id = mso_schema.ms_prod.id
  template_name = local.stretched_template_name
  site_id = data.mso_site.site1.id
  undeploy = !local.templates_deploy
}

resource "mso_schema_template_deploy" "template_stretched_s2_deployer" {
  schema_id = mso_schema.ms_prod.id
  template_name = local.stretched_template_name
  site_id = data.mso_site.site2.id
  undeploy = !local.templates_deploy
}

resource "mso_schema_template_deploy" "template_local_s1_deployer" {
  schema_id = mso_schema.ms_prod.id
  template_name = local.site1_template_name
  site_id = data.mso_site.site1.id
  undeploy = !local.templates_deploy
}

resource "mso_schema_template_deploy" "template_local_s2_deployer" {
  schema_id = mso_schema.ms_prod.id
  template_name = local.site2_template_name
  site_id = data.mso_site.site2.id
  undeploy = !local.templates_deploy
}





