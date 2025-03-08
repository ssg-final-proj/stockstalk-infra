region = "ap-northeast-2"

route53_zone_name = "tf.private.com"
rds_dns_name = "rds.tf.private.com"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  "subnet_1" = "10.0.1.0/24"
  "subnet_2" = "10.0.2.0/24"
}

availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

private_subnets = {
  "subnet_1" = "10.0.3.0/24"
  "subnet_2" = "10.0.4.0/24"
}

rds_subnets = {
  "subnet_1" = "10.0.5.0/24"
  "subnet_2" = "10.0.6.0/24"
}

bastion_ami_id = "ami-0a20b1b99b215fb27"
bastion_instance_type = "t3.micro"
tf_bastion_key_name = "tf-bastion-key"
tf_bastion_sg_name = "tf-bastion-sg"
