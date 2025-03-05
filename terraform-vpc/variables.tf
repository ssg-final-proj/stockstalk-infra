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

################ bastion.tf ################
variable "private_key_path" {
  description = "생성된 콘솔 서버용 키 파일 저장 경로"
  type        = string
}

variable "file_permission" {
  description = "파일에 적용할 POSIX 권한"
  type        = string
}

variable "bastion_ami_id" {
  description = "콘솔 서버용 Amazon Linux 2 AMI ID"
  type        = string
}

variable "bastion_instance_type" {
  description = "콘솔 서버 EC2 인스턴스 유형"
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