terraform {
  backend "s3" {
    bucket         = "tf-terraform-state-bucket-apucpa4m"
    key            = "terraform/addons/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "tf-terraform-lock-table"
  }
}

