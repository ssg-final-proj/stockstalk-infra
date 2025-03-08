# Bastion Host 정보 출력
output "bastion_public_ip" {
  value = aws_instance.tf_bastion.public_ip
}

############## eks 폴더에서 필요한 정보들 출력
# VPC ID 출력
output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

# 프라이빗 서브넷 IDs (EKS 클러스터 및 노드 그룹용)
output "private_subnet_ids" {
  value = [aws_subnet.tf_pri_sub_1.id, aws_subnet.tf_pri_sub_2.id]
}

# 퍼블릭 서브넷 IDs
output "public_subnet_ids" {
  value = [aws_subnet.tf_pub_sub_1.id, aws_subnet.tf_pub_sub_2.id]
}

# Bastion 보안 그룹 ID
output "bastion_sg_id" {
  value = aws_security_group.tf_bastion_sg.id
}

# EKS 클러스터 보안 그룹 ID
output "eks_sg_id" {
  value = aws_security_group.tf_eks_cluster_sg.id
}
