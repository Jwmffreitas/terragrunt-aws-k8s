terraform {
  backend "s3" {}
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.33.1"
  cluster_name    = var.cluster_name
  cluster_version = "1.32"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.micro"]
      disk_size      = 20
    }
  }

  enable_cluster_creator_admin_permissions = true 
  cluster_security_group_id = aws_security_group.eks_sg.id

  tags = {
    Environment = var.env
  }
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOF
- rolearn: ${module.eks.eks_managed_node_groups["default"].iam_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
EOF
  }
}

