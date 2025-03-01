data "aws_ecr_authorization_token" "auth_token" {}

output "login_command" {
  value = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app_repository.repository_url}"
}
