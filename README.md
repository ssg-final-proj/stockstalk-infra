# Stockstalk – Infrastructure (Terraform)

Stockstalk 서비스의 AWS 인프라를 Terraform 기반으로 관리하는 저장소입니다.  
EKS 클러스터, 네트워크, RDS 및 Kubernetes addons 구성을 **Infrastructure as Code** 방식으로 정의합니다.

![finalproject-AWS drawio](https://github.com/user-attachments/assets/d4f0af46-7bd6-4300-b2a2-88dd193a2f6f)

## 개요

이 저장소는 Infrastructure as Code(IaC) 방식으로 AWS 리소스를 관리합니다.  
네트워크, EKS 클러스터, 데이터베이스 및 Kubernetes addon 구성을 Terraform으로 정의하며,  
구성은 `backend` → `network` → `eks` → `addons` 순서로 적용하는 전제입니다.

## Terraform Workflow

인프라는 다음 순서로 구성됩니다.

- **backend**
  - Terraform state 저장소 구성
  - S3 + DynamoDB 기반 remote state 관리

- **network**
  - VPC, Public / Private Subnet, Routing, Bastion 구성

- **eks**
  - EKS Cluster, Node Group, RDS, Private Route53 구성

- **addons**
  - Helm 기반 Kubernetes addons 배포 구성

## Infrastructure Architecture

Terraform을 통해 아래 인프라 리소스를 구성합니다.

- VPC
- Public / Private Subnet
- EKS Cluster
- EKS Node Group
- RDS (MySQL)
- Route53
- Bastion Host
- Kubernetes Addons

전체 인프라 구성 흐름은 아래와 같습니다.

```text
Internet
   ↓
Route53
   ↓
ALB
   ↓
EKS Cluster
   ↓
Kubernetes Services
   ↓
RDS / Redis / Kafka
```

## 폴더 구조

### `backend/`

Terraform state 관리를 위한 S3 / DynamoDB, 키 / 도메인 관련 리소스를 구성합니다.

- `s3_dynamodb.tf`
- `terraform-backend.tf`
- `key.tf`
- `route53-public.tf`
- `provider.tf`
- `variables.tf`
- `output.tf`
- `terraform.tfvars`

### `network/`

VPC 및 퍼블릭 / 프라이빗 서브넷, 라우팅과 bastion 구성을 포함합니다.

- `vpc.tf`
- `public_subnet.tf`
- `private_subnet.tf`
- `bastion.tf`
- `provider.tf`
- `variables.tf`
- `output.tf`
- `terraform.tfvars`

### `eks/`

EKS 클러스터 / 노드그룹, RDS, 프라이빗 Route53 등을 구성합니다.

- `eks_cluster.tf`
- `eks_nodegroup.tf`
- `eks-addons.tf`
- `rds.tf`
- `route53-private.tf`
- `userdata.tpl`
- `provider.tf`
- `variables.tf`
- `data.tf`
- `output.tf`
- `terraform.tfvars`

### `addons/`

Helm 기반 Kubernetes addon 배포 구성을 관리합니다.

- `helm-addons.tf`
- `provider.tf`
- `variables.tf`
- `data.tf`
- `terraform.tfvars`

## 접근 / 작업 방식

기본 접근은 Session Manager(SSM) 기준으로 합니다.  
Terraform은 로컬에서 실행하고, `kubectl` / `helm` 작업도 기본은 로컬에서 kubeconfig로 수행합니다.  
bastion은 필요할 때만 제한적으로 사용합니다.

## 적용 / 실행

폴더별로 동일하게 실행합니다.

```bash
# 1) backend -> network -> eks -> addons 순서로 각 폴더에서 실행
terraform init
terraform apply

# 2) EKS 연결
aws eks --region ap-northeast-2 update-kubeconfig --name <cluster-name>
kubectl get nodes
```

자세한 환경 준비, 도구 설치, External Secrets Operator 설치 흐름은 `README2.md`에 정리되어 있습니다.

