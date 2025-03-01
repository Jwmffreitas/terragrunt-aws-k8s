remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-devops-jwmffreitas"
    key            = "cloud-architecture/terragrunt-aws-k8s.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
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
