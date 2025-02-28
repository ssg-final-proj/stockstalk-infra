```
# Helm 설치
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 설치 확인
helm version

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
