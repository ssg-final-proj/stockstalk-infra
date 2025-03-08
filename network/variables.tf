################ provider.tf ################
variable "region" {
  description = "AWS region"
  type        = string
}

################ route53-private.tf ################
variable "route53_zone_name" {
  description = "Route 53 프라이빗 hosted zone 이름"
  type        = string
}

variable "rds_dns_name" {
  description = "RDS의 Route53 DNS 레코드 이름"
  type        = string
}

################ vpc.tf ################
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

################ public_subnet.tf ################
variable "public_subnets" {
  description = "퍼블릭 서브넷 CIDRs"
  type        = map(string)
}

variable "availability_zones" {
  description = "서브넷에 할당할 가용영역"
  type        = list(string)
}

################ private_subnet.tf ################
variable "private_subnets" {
  description = "프라이빗 서브넷 CIDRs"
  type        = map(string)
}

################ bastion.tf ################
variable "tf_bastion_key_name" {
  description = "bastion host's key name"
  type = string
}

variable "bastion_ami_id" {
  description = "콘솔 서버용 Amazon Linux 2 AMI ID"
  type        = string
}

variable "bastion_instance_type" {
  description = "콘솔 서버 EC2 인스턴스 유형"
  type        = string
}

variable "tf_bastion_sg_name" {
  description = "bastion security group's name"
  type = string
}

variable "tf_eks_node_group_sg_name" {
  description = "EKS 노드그룹의 보안그룹 이름"
  type        = string
}
