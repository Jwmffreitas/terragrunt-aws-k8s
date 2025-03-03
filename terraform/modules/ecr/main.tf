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

resource "null_resource" "build_and_push_image" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app_repository.repository_url}
      docker build -t hello-eks ../../../application
      docker tag hello-eks:latest ${aws_ecr_repository.app_repository.repository_url}:latest
      docker push ${aws_ecr_repository.app_repository.repository_url}:latest
    EOT
  }

  depends_on = [aws_ecr_repository.app_repository]
}

