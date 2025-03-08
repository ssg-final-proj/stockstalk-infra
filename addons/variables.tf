variable "region" {
  description = "생성할 리전"
  type = string
}

variable "s3_bucket_name" {
  description = "state 파일 저장할 s3 버킷 이름"
  type = string
}

variable "s3_bucket_key" {
  description = "state 파일 저장할 s3 버킷 key"
  type = string
}

# variable "dynamodb_table_name" {
#   description = "state 파일 저장할 DynamoDB 테이블 이름"
#   type = string
# }

variable "route53_hosted_zone_id" {
  description = "Route53 퍼블릭 호스팅 영역 ID"
  type = string
} 
