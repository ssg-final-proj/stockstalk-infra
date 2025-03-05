# Kubernetes Provider 설정
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_name]
    command     = "aws"
  }
}

# Helm Provider 설정
provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_name]
      command     = "aws"
    }
  }
}

# helm으로 설치하는 addon들 설치
module "eks_blueprints_addons" {
  source                 = "aws-ia/eks-blueprints-addons/aws"
  version                = "~> 1.0"

  cluster_name           = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_endpoint       = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_version        = "1.31"
  oidc_provider_arn      = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  ### terraform-vpc에서 주석처리했던 helm으로 설치하는 addon들
  enable_aws_load_balancer_controller    = true
  # enable_cluster_proportional_autoscaler = true   # 이것 때문에 terraform apply 가 계속 오류났었음 (사용하면 HPA를 사용하지 않을 수도 있을 것 같아서 하고싶었는데 실패함)
  enable_karpenter                       = false
  enable_kube_prometheus_stack           = false
  enable_metrics_server                  = true
  enable_external_dns                    = true
  enable_cert_manager                    = true
  cert_manager_route53_hosted_zone_arns  = ["arn:aws:route53:::hostedzone/${var.route53_hosted_zone_id}"]   # 수정해주기

  depends_on = [
    data.terraform_remote_state.eks
  ]   

  tags                                   = {
    Environment                          = "dev"
  }
}
