terraform {
  backend "s3" {}
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.33"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

    eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t2.micro"]
    }
  }

  tags = {
    Environment = var.env
  }
}
