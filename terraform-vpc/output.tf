# Bastion Host 정보 출력
output "bastion_public_ip" {
  value = aws_instance.tf_bastion.public_ip
}

# RDS 정보 출력
output "rds_endpoint" {
  value = aws_route53_record.tf_rds_endpoint.name
}



# terraform-addons에서 사용할 변수들 추가됨

output "cluster_name" {
  value = aws_eks_cluster.tf_eks_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.tf_eks_cluster.endpoint
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.tf_oidc_provider.arn
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data
}
