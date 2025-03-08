# tls_private_key 생성 (개인 키)
resource "tls_private_key" "tf_bastion_key" {
  algorithm   = "RSA"
}

# 생성된 키페어 개인 키 pem 형식으로 인코딩하여 로컬로 다운
resource "local_file" "tf_bastion_private_key" {
  content  = tls_private_key.tf_bastion_key.private_key_pem
  filename = var.private_key_path
  file_permission = var.file_permission
}

# 생성된 키페어 공개 키 생성
resource "aws_key_pair" "tf_bastion_key" {
  key_name   = "tf-bastion-key"
  public_key = tls_private_key.tf_bastion_key.public_key_openssh

  tags = {
    Name = "tf_bastion_key"
  }
}
