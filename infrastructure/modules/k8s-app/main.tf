resource "aws_ecr_repository" "k8s-app-repo" {
  name = var.repo-name
}

resource "kubernetes_deployment" "k8s-app" {
  metadata {
    name = var.kubernetes_deployment_name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "infra-bot"
      }
    }

    template {
      metadata {
        labels = {
          app = "infra-bot"
        }
      }
    spec {
      container {
        name  = "infra-bot"
        image = "427071048654.dkr.ecr.us-west-2.amazonaws.com/simple-app:latest"
        port {
          container_port = 80
        }
      }
    }
   }
  }
}
