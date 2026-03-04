resource "aws_route53_zone" "dev_internal" {
  name = "dev.internal"

  vpc {
    vpc_id = var.vpc_id
  }
}


resource "aws_route53_record" "db_record" {
  zone_id = aws_route53_zone.dev_internal.zone_id
  name    = "db.dev.internal"
  type    = "CNAME"
  ttl     = 60
  records = [var.rds_endpoint]
}