variable "region" {}
variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "node_count" { default = 2 }
variable "ssh_key_name" { default = "" }
variable "env" {}
