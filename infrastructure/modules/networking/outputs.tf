output "vpc_id" {
    value = module.vpc.vpc_id
}

output "subnets_ids" {
    value = module.vpc.public_subnets
}
  
output "control_plane_subnets_ids" {
    value = module.vpc.private_subnets
}