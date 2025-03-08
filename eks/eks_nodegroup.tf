# Launch Template 정의
resource "aws_launch_template" "tf_eks_node_lt" {
  name_prefix   = var.eks_node_lt
  image_id      = var.eks_node_ami_id  # EKS 지원 AMI ID (Amazon Linux 2 AMI)
  instance_type = var.eks_instance_type  # 인스턴스 타입 큰걸로 쓰기 (VPC CNI 이슈 : 작은걸로 하면, 파드 수에 제한이 있다는 오류 뜸)

  vpc_security_group_ids = [aws_security_group.tf_eks_node_group_sg.id] 

  block_device_mappings {
    device_name = "/dev/xvda"        # Amazon Linux 2 기본 루트 디바이스
    ebs {
      volume_size = var.volume_size               # disk_size 지정
      volume_type = var.volume_type            # 최신 EBS 타입
      iops = var.iops                    # 기본값 : 3000 (gp3 기준)
      throughput = var.throughput               # 기본값 : 125 (gp3 기준)
    }
  }

  # 태그 적용
  tags = {
    Name = var.eks_node_lt
    "eks:cluster-name"   = var.eks_cluster_name
    "eks:nodegroup-name" = var.eks_node_group_name
  }

  
  # 태그를 tags 블록으로 설정하면 Launch Template 자체에만 적용됨
  # EC2 인스턴스 및 EBS 볼륨에도 적용되도록 tag_specifications 사용해야 함
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name                 = var.eks_node_lt
      "eks:cluster-name"   = var.eks_cluster_name
      "eks:nodegroup-name" = var.eks_node_group_name
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name                 = var.eks_node_lt
      "eks:cluster-name"   = var.eks_cluster_name
      "eks:nodegroup-name" = var.eks_node_group_name
    }
  }

  user_data = base64encode(templatefile("userdata.tpl", { CLUSTER_NAME = aws_eks_cluster.tf_eks_cluster.name, B64_CLUSTER_CA = aws_eks_cluster.tf_eks_cluster.certificate_authority[0].data, API_SERVER_URL = aws_eks_cluster.tf_eks_cluster.endpoint, CONTAINER_RUNTIME = "containerd" }))

}

# AWS eks_node_group 생성
resource "aws_eks_node_group" "tf_eks_managed_node_group" {
  cluster_name    = aws_eks_cluster.tf_eks_cluster.name                       # (Required)
  node_group_name = var.eks_node_group_name                               # (Optional)
  node_role_arn   = aws_iam_role.tf_eks_managed_node_group_iam_role.arn       # (Required)
  subnet_ids      = [aws_subnet.tf_pri_sub_1.id, aws_subnet.tf_pri_sub_2.id]  # (Required)

  launch_template {
    id      = aws_launch_template.tf_eks_node_lt.id
    version = "$Latest"
  }

  scaling_config {                     # (Required)
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  capacity_type  = "SPOT"  # 인스턴스 타입 큰걸로 바꾸는 대신 ON_DEMAND 대신 SPOT 인스턴스 사용

  update_config {                      # (Optional)
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.tf_eks_managed_node_group_policy_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tf_eks_managed_node_group_policy_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tf_eks_managed_node_group_policy_AmazonEC2ContainerRegistryReadOnly,
  ]

tags = {
    Name = "tf_eks_managed_node_group"
  }
}



# 노드 그룹 IAM 역할
resource "aws_iam_role" "tf_eks_managed_node_group_iam_role" {
  name = var.tf_eks_managed_node_group_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# 노드 그룹이 EKS 클러스터와 상호작용할 수 있도록 필요한 정책 연결
resource "aws_iam_role_policy_attachment" "tf_eks_managed_node_group_policy_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tf_eks_managed_node_group_iam_role.name
}

resource "aws_iam_role_policy_attachment" "tf_eks_managed_node_group_policy_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tf_eks_managed_node_group_iam_role.name
}

resource "aws_iam_role_policy_attachment" "tf_eks_managed_node_group_policy_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tf_eks_managed_node_group_iam_role.name
}

# 추가
resource "aws_iam_role_policy_attachment" "tf_eks_managed_node_group_policy_AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.tf_eks_managed_node_group_iam_role.name
}



# Route 53 조작을 위한 IAM 정책 생성
resource "aws_iam_policy" "external_dns_route53_policy" {
  name        = var.external_dns_route53_policy_name
  description = "Policy for ExternalDNS to manage Route53 records"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ChangeResourceRecordSets"
        ]
        Resource = "*"
      }
    ]
  })
}

# 노드 그룹 IAM 역할에 Route 53 정책 연결
resource "aws_iam_role_policy_attachment" "external_dns_route53_attachment" {
  policy_arn = aws_iam_policy.external_dns_route53_policy.arn
  role       = aws_iam_role.tf_eks_managed_node_group_iam_role.name
}



# 노드그룹의 보안그룹
resource "aws_security_group" "tf_eks_node_group_sg" {
  name        = var.tf_eks_node_group_sg_name
  description = "EKS Node Group Security Group"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.tf_bastion_sg.id]
  }

  ingress {
    from_port       = 53
    to_port         = 53
    protocol        = "udp"
    description     = "Node to node CoreDNS UDP"
    self            = true
  }

  ingress {
    from_port       = 53
    to_port         = 53
    protocol        = "tcp"
    description     = "Node to node CoreDNS"
    self            = true
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Cluster API to node groups"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    description     = "Node to node ingress on ephemeral ports"
    self            = true
  }

  ingress {
    from_port       = 10250
    to_port         = 10250
    protocol        = "tcp"
    description     = "Cluster API to node kubelets"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  ingress {
    from_port       = 4443
    to_port         = 4443
    protocol        = "tcp"
    description     = "Cluster API to node 4443/tcp webhook"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  ingress {
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    description     = "Cluster API to node 6443/tcp webhook"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  ingress {
    from_port       = 8443
    to_port         = 8443
    protocol        = "tcp"
    description     = "Cluster API to node 8443/tcp webhook"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  ingress {
    from_port       = 9443
    to_port         = 9443
    protocol        = "tcp"
    description     = "Cluster API to node 9443/tcp webhook"
    security_groups = [aws_security_group.tf_eks_cluster_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_eks_node_group_sg"
  }
}
