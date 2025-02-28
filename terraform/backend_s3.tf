terraform {
  backend "s3" {                                           # backend 블록은 Terraform이 실행될 때 한 번만 실행됨 (동적인 리소스를 참조할 수 없음)
    bucket         = "tf-terraform-state-bucket-XXXX"      # S3 버킷 이름 직접 입력 : 버킷 이름 랜덤으로 생성되므로 output 보고 수정 필요!
    key            = "terraform/state/terraform.tfstate"   # 상태 파일 저장 경로
    region         = "ap-northeast-2"                      # 리전 정보 직접 입력
    encrypt        = true                                  # 상태 파일 암호화 활성화
    dynamodb_table = "tf-terraform-lock-table"             # DynamoDB 테이블 이름 직접 입력
  }
}
