# 랜덤으로 생성된 S3 버킷 이름 출력 : tf-terraform-state-bucket-XXXXXXXX
output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.tf_terraform_state_bucket.bucket
}

# S3 버킷 리전 출력
output "s3_bucket_region" {
  description = "The AWS region where the S3 bucket is located"
  value       = aws_s3_bucket.tf_terraform_state_bucket.region
}

# DynamoDB 테이블 이름 출력
output "dynamodb_table_name" {
  value = aws_dynamodb_table.tf_terraform_locks.name
}

# Route53-public 호스팅 영역 ID 출력
output "route53_hosted_zone_id" {
  value = aws_route53_zone.tf_route53_public.zone_id
}

# 리전
output "region" {
  description = "Provider 리전"
  value = provider.aws.region
}
