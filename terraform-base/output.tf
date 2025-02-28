# 랜덤으로 생성된 S3 버킷 이름 출력
output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.tf_terraform_state_bucket.bucket
}

# S3 버킷 리전 출력
output "s3_bucket_region" {
  description = "The AWS region where the S3 bucket is located"
  value       = aws_s3_bucket.tf_terraform_state_bucket.region
}
