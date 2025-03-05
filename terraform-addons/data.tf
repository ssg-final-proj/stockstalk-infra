# S3에서 Terraform 상태 가져오기
data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = var.s3_bucket_name
    key    = var.s3_bucket_key
    region = var.s3_bucket_region
  }
}

