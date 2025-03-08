[terraform@ip-192-168-20-77 terraform-infra]$ cat backend_infra.tf
# terraform_infra.tf
terraform {
  backend "s3" {
    bucket         = "tf-terraform-state-bucket-xvpie8v5"  # S3 버킷 이름 output 보고 수정
    key            = "terraform/infra/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "tf-terraform-lock-table"             # DynamoDB 테이블 이름 입력
    encrypt        = true
  }
}
