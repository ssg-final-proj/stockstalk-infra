# 1. S3 버킷 생성
# AWS에서 S3 버킷을 생성할 때 리전을 명시하지 않으면 기본값으로 "us-east-1" (버지니아 북부 리전) 에 생성됨
resource "aws_s3_bucket" "tf_terraform_state_bucket" {
  bucket = "tf-terraform-state-bucket-${random_string.suffix.result}"   # 원하는 버킷 이름 + 랜덤값
  force_destroy = true   # S3 버킷을 삭제할 때 자동으로 모든 객체와 버전을 삭제

  tags = {
    Name        = "tf_terraform_state_bucket"
    Environment = "dev"
  }
}

# 랜덤 접미사 생성 (고유한 버킷 이름 보장)
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 버킷 버전 관리 활성화
resource "aws_s3_bucket_versioning" "tf_terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.tf_terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled" # 버전 관리 활성화
  }
}

# S3 버킷에 저장되는 파일을 자동으로 암호화 : 서버 측 암호화 (SSE) ⇒ Terraform 상태 파일이 암호화된 상태로 저장됨 (보안 강화)
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.tf_terraform_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"   # AES256 알고리즘을 사용하여 암호화 ⇒ AWS KMS(키 관리 서비스) 없이 기본적인 보안 제공
    }
  }
}

# S3 버킷 소유권 설정 : ACL이 사용되지 않도록 설정하여 버킷 및 객체 권한을 명확하게 설정 (최신 AWS 정책에 맞춰 사용해야 하는 필수 설정)
resource "aws_s3_bucket_ownership_controls" "tf_terraform_state_bucket_ownership" {
  bucket = aws_s3_bucket.tf_terraform_state_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"   # 버킷의 소유자가 모든 객체를 자동으로 소유
  }
}



# 2. DynamoDB 테이블 생성
resource "aws_dynamodb_table" "tf_terraform_locks" {
  name         = "tf-terraform-lock-table" # 원하는 테이블 이름
  billing_mode = "PAY_PER_REQUEST"      # 사용량 기반 요금제
  hash_key     = "LockID"               # 해시 키 설정
  attribute {
    name = "LockID"
    type = "S"                          # 문자열(String) 타입의 해시 키
  }
  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}
