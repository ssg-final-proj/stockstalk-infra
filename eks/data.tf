# network의 terraform state를 불러옴
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tf-terraform-state-bucket-vss-2025"
    key    = "terraform/network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
