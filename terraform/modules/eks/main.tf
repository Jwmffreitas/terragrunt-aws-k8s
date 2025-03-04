terraform {
  backend "s3" {}
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.33.1"
  cluster_name    = var.cluster_name
  cluster_version = "1.32"
  subnet_ids      = var.public_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = ["t3.small"]
      disk_size      = 20
    }
  }

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  enable_cluster_creator_admin_permissions = true
  cluster_security_group_id                = aws_security_group.eks_sg.id

  tags = {
    Environment = var.env
  }
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
  }

  depends_on = [module.eks]
}

resource "local_file" "aws_auth_config" {
  filename = "${path.module}/aws-auth.yaml"
  content  = <<-EOT
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: aws-auth
      namespace: kube-system
    data:
      mapRoles: |
        - rolearn: ${module.eks.eks_managed_node_groups["default"].iam_role_arn}
          username: system:node:{{EC2PrivateDNSName}}
          groups:
            - system:bootstrappers
            - system:nodes
  EOT
}


resource "null_resource" "apply_aws_auth" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.aws_auth_config.filename}"
  }

  depends_on = [module.eks, null_resource.update_kubeconfig]
}

