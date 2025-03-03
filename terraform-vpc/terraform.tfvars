s3_bucket_name = ""                               # tf-terraform-state-bucket-XXXX 형식
s3_bucket_region = "ap-northeast-2"               # terraform state 파일 저장될 s3 버킷 리전
dynamodb_table_name = "tf-terraform-lock-table"   # tf-terraform-lock-table

route53_hosted_zone_id = ""                       # Route53 → 호스팅 영역 → 사용할 퍼블릭 호스팅 영역 → 호스팅 영역 ID
