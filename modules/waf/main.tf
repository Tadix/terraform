resource "aws_wafv2_web_acl" "geo_restriction" {
  name        = "GeoRestriction"
  scope       = "REGIONAL"
  description = "Block access from Algeria"

  default_action {
    allow {}
  }

  rule {
    name     = "BlockAlgeria"
    priority = 1
    action {
      block {}
    }

    statement {
      geo_match_statement {
        country_codes = ["DZ"]
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockAlgeria"
      sampled_requests_enabled   = true
    }

  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "GeoRestriction"
    sampled_requests_enabled   = false
  }

}

resource "aws_wafv2_web_acl_association" "association_lb_waf" {
  resource_arn = var.lb_arn
  web_acl_arn  = aws_wafv2_web_acl.geo_restriction.arn
}
