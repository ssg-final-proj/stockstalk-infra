# Terraform 실행

**기본적인 리소스 생성**  
```
# GitHub에서 Terraform 코드 clone <br>
git clone -b 20-terraform https://github.com/hj-s18/terraform-aws.git

# terraform-infra 폴더 들어가서 init, apply 
terraform init
terraform apply --auto-approve

# 이 아래는 지금은 생략 가능 : infra에서 만든 것들은 vpc에서 output 보고 하드코딩 해줘서 resource로 참조 안 함
# terraform-infra 폴더에 backend-infra 파일 내용 주석 처리 제거 후 init, apply 
```

- `Route 53 Public Hosted Zone` 생성
  - 특정 도메인을 사용하여 DNS 설정할 때 필요
  
- Terraform 상태 관리용 `S3 버킷` + `DynamoDB 테이블` 생성
  - S3 : Terraform 상태 파일 저장 역할
  - DynamoDB : Terraform State Lock을 관리하여 동시 실행 방지 역할
    
⇒ output 참고하여 terraform-vpc 폴더의 `terraform.tfvars`, `backend_vpc.tf` 파일 수정 <br>

<br>

**Terraform 코드로 인프라 생성 완료**
```
# terraform-vpc 폴더 들어가서 init, apply
terraform init
terraform apply --auto-approve

# terraform 실행하는 로컬에서도 만들어진 eks 클러스터와 연결하기
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
aws eks --region ap-northeast-2 update-kubeconfig --name tf-eks-cluster

# terraform-addons 폴더 들어가서 init, apply
terraform init
terraform apply --auto-approve

# terraform-vpc 폴더 들어가서 생성된 bastion 퍼블릭 IP 확인
terraform output
```

<br>

**생성된 Bastion으로 접속**
```
# ssh 명령으로 생성된 bastion에 접속
ssh -i /home/terraform/bastion-key.pem ec2-user@<bastion_ip>
```

<br>
<br>
<br>

# MySQL 설치 ⇒ Bastion에서 RDS 접근 가능

```
sudo yum update -y
sudo yum install mysql -y
```

<br>
<br>
<br>


# AWS CLI 설정, kubectl, eksctl 설치

```
# aws cli 설정
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure

# 현재 설정된 AWS 계정 정보 확인
aws sts get-caller-identity

# aws cli 연결 확인
cat .aws/credentials
cat .aws/config
```

```
# kubectl 설치
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# EKS 클러스터와 kubectl 연결
aws eks --region ap-northeast-2 update-kubeconfig --name tf-eks-cluster

# kubectl 연결 확인
cat ~/.kube/config

# kubectl alias 영구 설정
echo 'alias k="kubectl"' >> ~/.bashrc
source ~/.bashrc
```

```
# eksctl 설치 (Amazon Linux 기준)
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# EKS 클러스터에 IAM OIDC Provider 설정
eksctl utils associate-iam-oidc-provider --region=ap-northeast-2 --cluster=tf-eks-cluster --approve
```

<br>
<br>
<br>

# Helm 설치, Helm으로 설치

참고 페이지 : [`🔗Amazon EKS에서 Helm을 사용하여 애플리케이션 배포`](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/helm.html)

```
# Helm 설치 (Linux)
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

# Helm 설치 (다른 방법)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 설치 확인
helm version
```

<br>

### External Secrets Operator 설치

```
# Helm 저장소 추가 (external-secrets)
helm repo add external-secrets https://charts.external-secrets.io

# Helm 저장소 업데이트
helm repo update

# External Secrets Operator 설치
helm install external-secrets external-secrets/external-secrets --namespace kube-system

# 설치 확인
kubectl get pods -n kube-system | grep external-secrets

# CRD 확인
kubectl get crds | grep external-secrets
```

<br>
<br>
<br>
