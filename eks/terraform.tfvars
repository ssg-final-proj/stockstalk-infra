region = "ap-northeast-2"

s3_bucket_name = "tf-terraform-state-bucket-vss-2025"
s3_bucket_key = "terraform/network/terraform.tfstate"

tf_rds_subnet_group_name = "tf-rds-subnet-group"
tf_rds_sg_name = "tf-rds-sg"
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

eks_cluster_name = "tf-eks-cluster"
eks_version = "1.31"
tf_eks_cluster_iam_role_name = "tf-eks-cluster-iam-role"      
tf_eks_cluster_sg_name = "tf-eks-cluster-sg"

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

tf_eks_managed_node_group_iam_role_name = "tf-eks-managed-node-role"
external_dns_route53_policy_name = "ExternalDNSRoute53Policy"
tf_eks_node_group_sg_name = "tf-eks-node-group-sg"
