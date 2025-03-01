terraform {
  source = "../../../modules/eks"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id         = "vpc-12345678"
    private_subnets = ["subnet-aaaa1111", "subnet-bbbb2222"]
  }
}


inputs = {
  region         = "us-east-2"
  cluster_name   = "dev-cluster"
  vpc_id         = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  node_count     = 2
  ssh_key_name   = "my-keypair"
  env            = "dev"
}
