resource "aws_route53_zone" "tf_route53_public" {  # 호스팅 영역 생성
  name = "stockstalk.store"   # (Required) The name of the hosted zone.
  force_destroy = true        # (Optional) Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone. 운영 환경에서는 false로 둬야 함!

  tags = {
    Environment = "dev"
  }
}

/*
# 우리는 이거 EKS에서 ingress로 생성할 예정임 ⇒ 필요 없음
resource "aws_route53_record" "tf_rds_endpoint" {
  zone_id = aws_route53_zone.tf_route53_public.zone_id
  name    = "alb.tf.public.com"
  type    = "A"
  ttl     = 300
  records = [aws_db_instance.tf_rds.address]
}
*/
