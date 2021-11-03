terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "spain-cn-lab"

    workspaces {
      name = "adealdag_demo_pvt"
    }
  }
}