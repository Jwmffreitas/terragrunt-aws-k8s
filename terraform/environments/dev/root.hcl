remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-devops-jwmffreitas"
    key            = "cloud-architecture/dev/${path_relative_to_include()}/terragrunt-aws-k8s.tfstate"
    region         = "us-east-2"
  }
}