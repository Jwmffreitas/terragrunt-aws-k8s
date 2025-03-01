terraform {
  source = "../../../modules/ecr"
}

inputs = {
  region         = "us-east-2"
  repository_name = "hello-eks"
  environment     = "dev"
}
