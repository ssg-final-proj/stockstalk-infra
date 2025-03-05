# Bastion Security Group
resource "aws_security_group" "tf_bastion_sg" {
  name   = "tf-bastion-sg"
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_bastion_sg"
  }
}


# Bastion Host EC2 instance
resource "aws_instance" "tf_bastion" {
  ami           = var.bastion_ami_id
  instance_type = var.bastion_instance_type
  subnet_id     = aws_subnet.tf_pub_sub_1.id
  key_name      = aws_key_pair.tf_bastion_key.key_name
  vpc_security_group_ids = [aws_security_group.tf_bastion_sg.id]
  associate_public_ip_address = true
  
  depends_on = [aws_key_pair.tf_bastion_key]

  tags = {
    Name = "bastion"
  }
}
