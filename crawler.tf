
resource "aws_glue_crawler" "OD_Pricing" {

  database_name = "pricing${var.env}"
  name          = "od_pricing${var.env}"
  role          = aws_iam_role.iam_role_for_pricing.arn

  s3_target {
    path = "s3://${var.output_bucket}${var.env}/Pricing/od_pricedata"
  }

  tags = {
    Team = "FinOps"
  }
}

resource "aws_glue_crawler" "SP_Pricing" {

  database_name = "pricing${var.env}"
  name          = "sp_pricing${var.env}"
  role          = aws_iam_role.iam_role_for_pricing.arn

  s3_target {
    path = "s3://${var.output_bucket}${var.env}/Pricing/sp_pricedata"
  }

  tags = {
    Team = "FinOps"
  }
}


resource "aws_glue_crawler" "OD_RDS_Pricing" {

  database_name = "pricing${var.env}"
  name          = "od_rds_pricing${var.env}"
  role          = aws_iam_role.iam_role_for_pricing.arn

  s3_target {
    path = "s3://${var.output_bucket}${var.env}/Pricing/od_pricedata_rds"
  }

  tags = {
    Team = "FinOps"
  }
}
