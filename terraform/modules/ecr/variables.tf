variable "region" {}

variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "environment" {
  description = "Ambiente em que a infraestrutura está sendo configurada"
  type        = string
}

variable "app_path" {
  description = "Caminho absoluto para a pasta application"
  type        = string
}
