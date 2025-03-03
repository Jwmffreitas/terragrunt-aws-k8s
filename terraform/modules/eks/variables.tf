variable "region" {}
variable "cluster_name" {}
variable "vpc_id" { type = string}
variable "private_subnets" { type = list(string)}
variable "public_subnets" { type = list(string)}
variable "node_count" { default = 2 }
variable "ssh_key_name" { default = "" }
variable "env" {}
variable "ecr_repo_url" {}
