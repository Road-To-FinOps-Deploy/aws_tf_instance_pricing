
resource "aws_glue_crawler" "OD_Pricing" {
  count         = var.trigger_count
  database_name = "pricing${var.env}"
  name          = "od_pricing${var.env}"
  role          = aws_iam_role.compute_optimizer_role.arn
  #schedule      = "cron(07 10 * * ? *)"

  s3_target {
    path = "s3://${var.cur_bucket}${var.env}/Pricing/od_pricedata"
  }

  tags = {
    Team = "FinOps"
  }
}

resource "aws_glue_crawler" "SP_Pricing" {
  count         = var.trigger_count
  database_name = "pricing${var.env}"
  name          = "sp_pricing${var.env}"
  role          = aws_iam_role.compute_optimizer_role.arn
  schedule      = "cron(07 10 * * ? *)"

  s3_target {
    path = "s3://${var.cur_bucket}${var.env}/Pricing/sp_pricedata"
  }

  tags = {
    Team = "FinOps"
  }
}


resource "aws_glue_crawler" "OD_RDS_Pricing" {
  count         = var.trigger_count
  database_name = "pricing${var.env}"
  name          = "od_rds_pricing${var.env}"
  role          = aws_iam_role.compute_optimizer_role.arn

  s3_target {
    path = "s3://${var.cur_bucket}${var.env}/Pricing/od_pricedata_rds"
  }

  tags = {
    Team = "FinOps"
  }
}
