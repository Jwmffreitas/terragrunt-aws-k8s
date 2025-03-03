resource "aws_security_group" "eks_sg" {
  name        = "eks-security-group"
  description = "Security Group for EKS nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir acesso HTTP público
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["187.62.242.130/32"]  # Permitir acesso HTTPS público
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir todo tráfego de saída
  }

  tags = {
    Name = "eks-sg"
  }
}
