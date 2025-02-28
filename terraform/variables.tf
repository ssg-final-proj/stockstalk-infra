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
