# Kubernetes Provider 설정
provider "kubernetes" {
  host                   = aws_eks_cluster.tf_eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.tf_eks_cluster.name]
    command     = "aws"
  }
}

# Helm Provider 설정
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.tf_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.tf_eks_cluster.name]
      command     = "aws"
    }
  }
}

# OIDC 프로바이더 생성
resource "aws_iam_openid_connect_provider" "tf_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  # thumbprint_list = [data.aws_iam_openid_connect_thumbprint.eks_thumbprint.thumbprint]
  url             = aws_eks_cluster.tf_eks_cluster.identity[0].oidc[0].issuer
}

module "eks_blueprints_addons" {
  source                 = "aws-ia/eks-blueprints-addons/aws"
  version                = "~> 1.0"

  cluster_name           = aws_eks_cluster.tf_eks_cluster.name
  cluster_endpoint       = aws_eks_cluster.tf_eks_cluster.endpoint
  cluster_version        = "1.31"
  oidc_provider_arn      = aws_iam_openid_connect_provider.tf_oidc_provider.arn

  eks_addons             = {
    aws-ebs-csi-driver   = { most_recent = true }
    coredns              = { most_recent = true }
    vpc-cni              = { most_recent = true }
    kube-proxy           = { most_recent = true }
  }

  /*
  ### Terraform에서 설치하지 않고 직접 설치하기 ###
  enable_aws_load_balancer_controller    = true
  # enable_cluster_proportional_autoscaler = true   # 이것 때문에 terraform apply 가 계속 오류났었음 (사용하면 HPA를 사용하지 않을 수도 있을 것 같아서 하고싶었는데 실패함)
  enable_karpenter                       = true
  enable_kube_prometheus_stack           = false   # Terraform이 Helm을 실행하여 kube-prometheus-stack 설치 : false로 어플라이 한 후 true로 바꿔서 다시 어플라이 하기
  enable_metrics_server                  = true
  enable_external_dns                    = true
  enable_cert_manager                    = true
  cert_manager_route53_hosted_zone_arns  = ["arn:aws:route53:::hostedzone/<Route53 → 호스팅 영역 → 사용할 퍼블릭 호스팅 영역 → 호스팅 영역 ID>"]   # 수정해주기
  */

  depends_on = [
    aws_eks_cluster.tf_eks_cluster   # EKS 클러스터 생성 후 실행
  ]   

  tags                                   = {
    Environment                          = "dev"
  }
}
