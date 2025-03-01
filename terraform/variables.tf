variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "route53_zone_name" {
  description = "Route 53 private hosted zone name"
  type        = string
  default     = "tf.private.com"
}

variable "rds_dns_name" {
  description = "RDS DNS record name"
  type        = string
  default     = "rds.tf.private.com"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = map(string)
  default = {
    "subnet_1" = "10.0.1.0/24"
    "subnet_2" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = map(string)
  default = {
    "subnet_1" = "10.0.3.0/24"
    "subnet_2" = "10.0.4.0/24"
  }
}

variable "rds_subnets" {
  description = "List of RDS subnet CIDRs"
  type        = map(string)
  default = {
    "subnet_1" = "10.0.5.0/24"
    "subnet_2" = "10.0.6.0/24"
  }
}

variable "rds_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "rds_engine" {
  description = "RDS database engine"
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "8.0"
}

variable "rds_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "rds_db_name" {
  description = "RDS 데이터베이스 이름"
  type        = string
  default     = "vss-db"
}
