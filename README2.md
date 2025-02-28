# Terraform 준비

```
# GitHub에서 Terraform 코드 clone <br>
git clone -b 19-terraform https://github.com/hj-s18/terraform-aws.git

# terraform-base 폴더 들어가서 init, apply <br>
terraform init
terraform apply --auto-approve


#### S3 버킷 생성됨, DynamoDB 테이블 생성됨
#### 생성된 S3와 DynamoDB 관련 output 참고하여 terraform 폴더의 backend_s3.tf 파일 수정


# terraform 폴더 들어가서 init, apply <br>
terraform init
terraform apply --auto-approve
```

<br>
<br>
<br>

# MySQL 설치

```
sudo yum update -y
sudo yum install mysql -y
```

<br>
<br>
<br>


# k8s 사용 준비 (aws cli 설정, kubectl, eksctl 설치)

```
# 생성된 bastion 퍼블릭 IP 확인
terraform output

# ssh 명령으로 생성된 bastion에 접속
ssh -i /home/terraform/bastion-key.pem ec2-user@<bastion_ip>

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

# helm 설치, Helm으로 설치

```
# Helm 설치
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 설치 확인
helm version
```

<br>

### External Secrets Operator 설치

```
# Helm 저장소 추가
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
