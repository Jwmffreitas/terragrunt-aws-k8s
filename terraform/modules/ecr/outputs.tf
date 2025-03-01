output "repository_url" {
  description = "URL do repositório ECR"
  value       = aws_ecr_repository.app_repository.repository_url
}
