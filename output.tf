output "vpc1_id" {
  value = module.vpcs[0].id
}

output "vpc1_name" {
  value = module.vpcs[0].name
}

output "vpc1_project" {
  value = module.vpcs[0].project
}

output "vpc1_routing_mode" {
  value = module.vpcs[0].routing_mode
}

output "vpc1_subnets" {
  value = {
    for subnet in keys(google_compute_subnetwork.vpc1_subnets) : subnet => {
      id            = google_compute_subnetwork.vpc1_subnets[subnet].id
      ip_cidr_range = google_compute_subnetwork.vpc1_subnets[subnet].ip_cidr_range
    }
  }
}

# output "vpc2_id" {
#   value = module.vpcs[1].id
# }

# output "vpc2_name" {
#   value = module.vpcs[1].name
# }

# output "vpc2_project" {
#   value = module.vpcs[1].project
# }

# output "vpc2_routing_mode" {
#   value = module.vpcs[1].routing_mode
# }


