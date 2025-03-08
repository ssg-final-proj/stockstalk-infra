terraform {
  backend "s3" {
    bucket         = "tf-terraform-state-bucket-vss-2025"
    key            = "terraform/addons/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tf-terraform-lock-table"
  }
}

