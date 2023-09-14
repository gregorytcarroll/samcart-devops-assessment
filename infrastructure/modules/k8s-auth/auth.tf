locals {
    yaml_quote = ""

    roles_to_map = [
        {
            rolearn = "arn:aws:iam::427071048654:role/github-actions-admin"
            username = "system:node:{{EC2PrivateDNSName}}"
            groups = [
                "system:bootstrappers",
                "system:nodes"
            ]
        },
        {
            rolearn = "arn:aws:iam::427071048654:role/github-actions-admin"
            username = "kube-admin-role"
        }
    ]
    users_to_map = [
        {
            userarn = "arn:aws:iam::427071048654:user/kube-admin"
            username = "kube-admin"
            groups = [
                "system:masters"
            ]
        }

    ]

}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles    = replace(yamlencode(local.roles_to_map), "\"", local.yaml_quote)
    mapUsers    = replace(yamlencode(local.users_to_map), "\"", local.yaml_quote)
  }
}


resource "kubernetes_cluster_role_binding" "kube-admin-role-binding" {
  metadata {
    name = "kube-admin-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "kube-admin-role"
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role" "cluster-viewer-role" {
  metadata {
    name = "cluster-viewer-role"
  }
  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "nodes", "configmaps", "clusterroles", "endpoints", "ingresses", "deployments", "services", "events", "persistentvolumeclaims", "persistentvolumes", "cronjobs", "horizontalpodautoscalers", "pods/log", "jobs"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role" "cluster-developer-role" {
  metadata {
    name = "cluster-developer-role"
  }
  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "nodes", "configmaps", "clusterroles", "endpoints", "ingresses", "deployments", "services", "events", "persistentvolumeclaims", "persistentvolumes", "cronjobs", "horizontalpodautoscalers",  "pods/log", "jobs"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods/portforward"]
    verbs      = ["get", "list", "watch", "create"]
  }
}
resource "kubernetes_cluster_role_binding" "cluster-viewer-role-binding" {
  metadata {
    name = "cluster-viewer-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.assumed_cluster_role
  }
  subject {
    kind      = "User"
    name      = "kube-viewer-role"
    api_group = "rbac.authorization.k8s.io"
  }
}
