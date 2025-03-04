terraform {
  source = "../../../modules/vpc"
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
EOF
}

inputs = {
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  azs             = ["us-east-2a", "us-east-2b"]
  env             = "dev"
}
