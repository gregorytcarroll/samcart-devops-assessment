# output "vpc_id" {
#     value = module.networking.vpc_id
# }

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}