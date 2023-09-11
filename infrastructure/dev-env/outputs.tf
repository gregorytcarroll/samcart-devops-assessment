output "vpc_id" {
    value = module.networking.vpc_id
}

output "subnets_ids" {
    value = module.networking.public_subnets
}
  
output "control_plane_subnets_ids" {
    value = module.networking.private_subnets
}