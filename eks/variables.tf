################ provider.tf ################
variable "region" {
  description = "AWS region"
  type        = string
}

################ data.tf ################
variable "s3_bucket_name" {
  description = "state 파일 저장할 s3 버킷 이름"
  type = string
}

variable "s3_bucket_key" {
  description = "state 파일 저장할 s3 버킷 key"
  type = string
}

################ rds.tf ################
variable "rds_subnets" {
  description = "RDS 서브넷 CIDRs"
  type        = map(string)
}

variable "rds_instance_class" {
  description = "RDS 인스턴스 유형"
  type        = string
}

variable "rds_storage" {
  description = "RDS에 할당된 스토리지 용량(GB단위)"
  type        = number
}

variable "rds_engine" {
  description = "RDS 데이터베이스 엔진"
  type        = string
}

variable "rds_engine_version" {
  description = "RDS 엔진 버전"
  type        = string
}

variable "rds_username" {
  description = "RDS 마스터 사용자 이름"
  type        = string
}

variable "rds_db_name" {
  description = "RDS 데이터베이스 이름"
  type        = string
}

variable "rds_storage_type" {
  description = "RDS에 사용할 스토리지 유형"
  type        = string
}

variable "tf_rds_subnet_group_name" {
  description = "RDS 서브넷 그룹 이름"
  type        = string
}

variable "tf_rds_sg_name" {
  description = "RDS 보안그룹 이름"
  type        = string
}

################ eks_cluster.tf ################
variable "eks_cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "eks_version" {
  description = "EKS 클러스터 버전"
  type        = string
}

variable "tf_eks_cluster_iam_role_name" {
  description = "EKS 클러스터 IAM 롤 이름"
  type = string
}


variable "tf_eks_cluster_sg_name"{
  description = "EKS 클러스터 보안그룹 이름"
  type = string
}

################ eks_nodegroup.tf ################
variable "eks_node_lt" {
  description = "EKS 노드 시작 템플릿 이름"
  type        = string
}

variable "eks_node_ami_id" {
  description = "EKS 노드 Amazon Linux 2 AMI ID"
  type        = string
}

variable "eks_instance_type" {
  description = "EKS 노드 (EC2) 인스턴스 유형"
  type        = string
}

variable "volume_size" {
  description = "EBS 볼륨 크기(GB 단위)"
  type        = number
}

variable "volume_type" {
  description = "EBS 볼륨 타입"
  type        = string
}

variable "iops" {
  description = "EBS IOPS 설정 (gp3 기준 기본값: 3000)"
  type        = number
}

variable "throughput" {
  description = "EBS 처리량 설정 (gp3 기준 기본값: 125)"
  type        = number
}

variable "eks_node_group_name" {
  description = "EKS 노드 그룹 이름"
  type        = string
}

variable "desired_size" {
  description = "EKS 노드 그룹의 초기 노드 개수"
  type        = number
}

variable "max_size" {
  description = "EKS 노드 그룹의 최대 노드 개수"
  type        = number
}

variable "min_size" {
  description = "EKS 노드 그룹의 최소 노드 개수"
  type        = number
}

variable "tf_eks_managed_node_group_iam_role_name" {
  description = "EKS 노드 그룹의 IAM 역할 이름"
  type        = string
}

variable "external_dns_route53_policy_name" {
  description = "Route 53 조작을 위한 IAM 정책 이름"
  type        = string
}
