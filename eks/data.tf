# network의 terraform state를 불러옴
/* data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.s3_bucket_name
    key    = var.s3_bucket_key
    region = var.region
  }
} */

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tf-terraform-state-bucket-vss-2025"
    key    = "terraform/network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

