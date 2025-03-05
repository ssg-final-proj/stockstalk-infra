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
rds_instance_class = "db.t3.micro"
rds_storage = 20
rds_engine = "mysql"
rds_engine_version = "8.0"
rds_username = "admin"
rds_db_name = "vss_db"
rds_storage_type = "gp3"

bastion_ami_id = "ami-0a20b1b99b215fb27"
bastion_instance_type = "t3.micro"

eks_cluster_name = "tf-eks-cluster"
eks_version = "1.31"

eks_node_lt = "tf-eks-node-lt"
eks_node_ami_id = "ami-0fa05db9e3c145f63"
eks_instance_type = "m5.xlarge"
volume_size           = 80
volume_type           = "gp3"
iops                  = 4000
throughput            = 250
eks_node_group_name = "tf-eks-managed-node-group"
desired_size = 3
max_size = 4
min_size = 2
