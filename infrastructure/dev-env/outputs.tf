output "vpc_id" {
    value = module.vpc.vpc_id
}

output "vpc_public_subnets" {
    value = module.vpc.public_subnets
}
  
output "vpc_control_plane_subnets" {
    value = module.vpc.private_subnets
}