locals {
  region2      = "europe-west3"
  vpc1_subnets = jsondecode(file("${path.module}/config/vpc1_subnets.json"))
}
# used this file
# https://cloud.google.com/network-connectivity/docs/vpn/how-to/automate-vpn-setup-with-terraform
module "name" {
  source           = "github.com/ParisaMousavi/gcp-naming?ref=master"
  prefix           = var.prefix
  name             = var.name
  environment      = var.environment
  region_shortname = var.region_shortname
}

module "vpcs" {
  source                  = "github.com/ParisaMousavi/gcp-vpc?ref=main"
  count                   = 2
  name                    = "${module.name.vpc}-${count.index}"
  project                 = var.project
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "vpc1_subnets" {
  for_each      = local.vpc1_subnets
  name          = "${module.name.snet}-${each.key}"
  ip_cidr_range = each.value.ip_cidr_range
  network       = module.vpcs[0].id
}

# resource "google_compute_subnetwork" "network1_subnet1" {
#   name          = "${module.name.snet}-1"
#   ip_cidr_range = "10.0.1.0/24"
#   network       = module.vpcs[0].id
# }

# resource "google_compute_subnetwork" "network1_subnet2" {
#   name          = "${module.name.snet}-2"
#   ip_cidr_range = "10.0.2.0/24"
#   network       = module.vpcs[0].id
# }

# resource "google_compute_subnetwork" "network1_gke" {
#   name          = "${module.name.snet}-gke"
#   ip_cidr_range = "10.0.3.0/24"
#   network       = module.vpcs[0].id
# }

# resource "google_compute_subnetwork" "network2_subnet1" {
#   name          = "${module.name.snet}-3"
#   ip_cidr_range = "192.168.1.0/24"
#   region        = local.region2
#   network       = module.vpcs[1].id
# }

# resource "google_compute_subnetwork" "network2_subnet2" {
#   name          = "${module.name.snet}-4"
#   ip_cidr_range = "192.168.2.0/24"
#   region        = local.region2
#   network       = module.vpcs[1].id
# }
