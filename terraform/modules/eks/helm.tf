resource "helm_release" "hello_eks" {
  name      = "hello-eks"
  chart     = "./hello-eks-0.1.0.tgz"
  namespace = "default"

  force_update  = true
  recreate_pods = true

  timeout = 600
  wait    = true

  set {
    name  = "image.repository"
    value = var.ecr_repo_url
  }

  set {
    name  = "image.tag"
    value = "latest"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "autoscaling.minReplicas"
    value = "1"
  }

  set {
    name  = "autoscaling.maxReplicas"
    value = "5"
  }

  set {
    name  = "autoscaling.targetCPUUtilizationPercentage"
    value = "80"
  }

  set {
    name  = "autoscaling.targetMemoryUtilizationPercentage"
    value = "80"
  }

  depends_on = [module.eks, null_resource.update_kubeconfig, null_resource.apply_aws_auth]
}

