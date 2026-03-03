# Stockstalk – Infrastructure (Terraform)

대규모 트래픽을 가정하여 확장성과 가용성을 중심으로 설계한 모의 주식 투자 플랫폼입니다.  
AWS와 EKS 기반 MSA 구조로 구성하여 확장성과 자동 배포를 고려했습니다.

![finalproject-AWS drawio](https://github.com/user-attachments/assets/d4f0af46-7bd6-4300-b2a2-88dd193a2f6f)


## 개요

이 저장소는 Stockstalk 서비스의 AWS 인프라를 Terraform으로 관리합니다.  
구성은 `backend` → `network` → `eks` → `addons` 순서로 적용하는 전제입니다.

## 폴더 구조

### backend/
Terraform state 관리를 위한 S3/DynamoDB, 키/도메인 관련 리소스를 구성합니다.

- `s3_dynamodb.tf`, `terraform-backend.tf`
- `key.tf`
- `route53-public.tf`
- `provider.tf`, `variables.tf`, `output.tf`, `terraform.tfvars`

### network/
VPC 및 퍼블릭/프라이빗 서브넷, 라우팅과 bastion 구성을 포함합니다.

- `vpc.tf`
- `public_subnet.tf`, `private_subnet.tf`
- `bastion.tf`
- `provider.tf`, `variables.tf`, `output.tf`, `terraform.tfvars`

### eks/
EKS 클러스터/노드그룹, RDS, 프라이빗 Route53 등을 구성합니다.

- `eks_cluster.tf`, `eks_nodegroup.tf`
- `eks-addons.tf`
- `rds.tf`
- `route53-private.tf`
- `userdata.tpl`
- `provider.tf`, `variables.tf`, `data.tf`, `output.tf`, `terraform.tfvars`

### addons/
Helm 기반 Kubernetes addon 배포 구성을 관리합니다.

- `helm-addons.tf`
- `provider.tf`, `variables.tf`, `data.tf`, `terraform.tfvars`

## 적용/실행

폴더별로 동일하게 실행합니다.

```bash
# 1) backend -> network -> eks -> addons 순서로 각 폴더에서 실행
terraform init
terraform apply

# 2) EKS 연결 (클러스터 이름은 환경에 맞게)
aws eks --region ap-northeast-2 update-kubeconfig --name <cluster-name>
kubectl get nodes

자세한 환경 준비/도구 설치/External Secrets Operator 설치 흐름은 README2.md에 정리되어 있습니다.
