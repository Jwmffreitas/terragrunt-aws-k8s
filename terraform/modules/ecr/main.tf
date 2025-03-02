terraform {
  backend "s3" {}
}

resource "aws_ecr_repository" "app_repository" {
  name = var.repository_name

  tags = {
    Name        = "app-repository"
    Environment = var.environment
  }
}
