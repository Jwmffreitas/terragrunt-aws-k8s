variable "region" {}

variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "environment" {
  description = "Ambiente em que a infraestrutura está sendo configurada"
  type        = string
}
