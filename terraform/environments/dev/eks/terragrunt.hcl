terraform {
  source = "../../../modules/eks"
}

include {
  path = find_in_parent_folders("root.hcl")
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
  provider "aws" {
    region = "us-east-2"
  }

  provider "kubernetes" {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }

  provider "kubectl" {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }

  provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  }
}

  data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_name
  }

  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
      kubectl = {
        source  = "gavinbunney/kubectl"
        version = "~> 1.19.0"
      }
    }
  }
EOF
}


dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id         = "vpc-08c2b405ad2297bf8"
    private_subnets = ["subnet-0411abbe0fc8c45bc", "subnet-0b2676c113e40648d"]
    public_subnets = ["subnet-0411abbe0fc8c45bc", "subnet-0b2676c113e40648d"]
  }
}

dependency "ecr" {
  config_path = "../ecr" 
}


inputs = {
  region          = "us-east-2"
  cluster_name    = "dev-cluster"
  vpc_id          = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  public_subnets  = dependency.vpc.outputs.public_subnets
  node_count      = 2
  env             = "dev"
  ecr_repo_url    = dependency.ecr.outputs.repository_url
}
