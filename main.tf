# used this file
# https://cloud.google.com/network-connectivity/docs/vpn/how-to/automate-vpn-setup-with-terraform
module "name" {
  source           = "github.com/ParisaMousavi/gcp-naming?ref=master"
  prefix           = var.prefix
  name             = var.name
  environment      = var.environment
  region_shortname = var.region_shortname
}

module "vpc" {
  source                  = "github.com/ParisaMousavi/gcp-vpc?ref=main"
  name                    = module.name.vpc
  project                 = var.project
  auto_create_subnetworks = false
}
