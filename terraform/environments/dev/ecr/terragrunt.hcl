terraform {
  source = "../../../modules/ecr"
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
  region         = "us-east-2"
  repository_name = "hello-eks"
  environment     = "dev"
  app_path = "/home/$USER/GitHub/terragrunt-aws-k8s/application"
}
