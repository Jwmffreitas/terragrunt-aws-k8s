resource "aws_ecr_repository" "app_repository" {
  name = var.repository_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "app-repository"
    Environment = var.environment
  }
}
