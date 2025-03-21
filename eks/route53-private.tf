resource "aws_route53_zone" "tf_route53_private" {
  name = var.route53_zone_name
  vpc {
    vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  }
}

resource "aws_route53_record" "tf_rds_endpoint" {
  zone_id = aws_route53_zone.tf_route53_private.zone_id
  name    = var.rds_dns_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.tf_rds.address]
}
