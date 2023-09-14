resource "aws_ecr_repository" "k8s-app-repo" {
  name = var.repo-name
}

data "aws_eks_cluster" "eks_cluster" {
  name = "testing-eks-cluster" 
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  config_path            = "./application/k8s/.kube/config"
  load_config_file       = false 
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
}


resource "kubernetes_namespace" "app" {
  metadata {
    name = "nginx"
  }
}
resource "kubernetes_deployment" "app" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.app.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "hello-world"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "app" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.app.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 80
    }
  }
}