# S3 버킷에 저장될 terraform 상태파일
terraform {
  backend "s3" {                                              # backend 블록은 Terraform이 실행될 때 한 번만 실행됨 ⇒ 동적인 리소스를 참조할 수 없음
    bucket         = "<s3_bucket_name>"                       # 수정 필요 : S3 버킷 이름 : terraform-infra에서 버킷 이름 랜덤으로 생성됨
    key            = "terraform/addons/terraform.tfstate"     # 상태 파일 저장 경로
    region         = "<s3_bucket_region>"                     # 확인 필요 : 리전 정보
    encrypt        = true                                     # 상태 파일 암호화 활성화
    dynamodb_table = "<dynamodb_table_name>"                  # 확인 필요 : DynamoDB 테이블 이름
  }
}
