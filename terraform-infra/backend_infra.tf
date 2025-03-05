# terraform-infra 정보 s3 버킷에 저장
terraform {
  backend "s3" {
    bucket         = "tf-terraform-state-bucket-apucpa4m"      # S3 버킷 이름 직접 입력 : 버킷 이름 랜덤으로 생성되므로 output 보고 수정 필요!
    key            = "terraform/infra/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "tf-terraform-lock-table"             # DynamoDB 테이블 이름 직접 입력
    encrypt        = true
  }
}
