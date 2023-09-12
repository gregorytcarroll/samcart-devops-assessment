module "eks_cluster" {
  source           = "terraform-aws-modules/eks/aws"
  cluster_name     = "my-eks-cluster"
  cluster_version  = "1.21"
  subnets          = module.vpc.private_subnets_ids
  vpc_id           = module.vpc.vpc_id
  tags             = { "Environment" = "Development" }

  workers_additional_security_group_ids = []  # Add any additional security groups needed

  fargate_profiles = [
    {
      name            = "dev"
      pod_execution_role_arn = aws_iam_role.eks_node_role.arn
      subnets_ids     = module.vpc.private_subnets_ids
      tags = { "Environment" = "Development" }
    }
  ]
}
