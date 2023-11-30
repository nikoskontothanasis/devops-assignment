provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "istio" {
  name       = "istio"
  repository = "https://istio.io/charts"
  chart      = "istio-base"
  version    = "4.6.0"
  namespace  = "istio-system"
  create_namespace = true
  set {
    name  = "global.hub"
    value = "docker.io/istio"
  }
  set {
    name  = "global.hub"
    value = "docker.io/istio"
  }
  # Add other necessary configurations
}
