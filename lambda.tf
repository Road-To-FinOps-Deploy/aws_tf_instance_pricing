
# SPTool_ODPricing_Download
data "archive_file" "sp_od_pricing_zip" {
  type        = "zip"
  source_file = "${path.module}/source/sptool_odpricing_download.py"
  output_path = "${path.module}/output/sp_od_pricing.zip"
}

resource "aws_lambda_function" "sp_od_pricing" {
  description      = "Gets on demand ec2 pricies"
  filename         = "${path.module}/output/sp_od_pricing.zip"
  function_name    = "SPTool_ODPricing_Download${var.env}"
  role             = aws_iam_role.iam_role_for_athena.arn
  handler          = "sptool_odpricing_download.lambda_handler"
  source_code_hash = data.archive_file.sp_od_pricing_zip.output_base64sha256
  runtime          = "python3.8"
  memory_size      = "2688"
  timeout          = "150"

  environment {
    variables = {
      BUCKET_NAME = "${var.cur_bucket}${var.env}"
    }
  }

  tags = {
    "Team" = "FinOps"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_sp_od_pricing" {
  count         = var.trigger_count
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sp_od_pricing.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sp_od_pricing_cloudwatch_rule[0].arn
}

resource "aws_cloudwatch_event_rule" "sp_od_pricing_cloudwatch_rule" {
  count               = var.trigger_count
  name                = "sp_od_pricing_lambda_trigger${var.env}"
  schedule_expression = var.service_dynamo_cron
}

resource "aws_cloudwatch_event_target" "sp_od_pricing_lambda" {
  count     = var.trigger_count
  rule      = aws_cloudwatch_event_rule.sp_od_pricing_cloudwatch_rule[0].name
  target_id = "sp_od_pricing_lambda_target${var.env}"
  arn       = aws_lambda_function.sp_od_pricing.arn
}

# SPTool_SPPricing_Download
data "archive_file" "sp_sp_pricing_zip" {
  type        = "zip"
  source_file = "${path.module}/source/sptool_sppricing_download.py"
  output_path = "${path.module}/output/sp_sp_pricing.zip"
}

resource "aws_lambda_function" "sp_sp_pricing" {
  description      = "Gets savings plans ec2 pricies"
  filename         = "${path.module}/output/sp_sp_pricing.zip"
  function_name    = "SPTool_SPPricing_Download${var.env}"
  role             = aws_iam_role.iam_role_for_athena.arn
  handler          = "sptool_sppricing_download.lambda_handler"
  source_code_hash = data.archive_file.sp_sp_pricing_zip.output_base64sha256
  runtime          = "python3.8"
  memory_size      = "2688"
  timeout          = "150"

  environment {
    variables = {
      BUCKET_NAME = "${var.cur_bucket}${var.env}"
    }
  }

  tags = {
    "Team" = "FinOps"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_sp_sp_pricing" {
  count         = var.trigger_count
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sp_sp_pricing.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sp_sp_pricing_cloudwatch_rule[0].arn
}

resource "aws_cloudwatch_event_rule" "sp_sp_pricing_cloudwatch_rule" {
  count               = var.trigger_count
  name                = "sp_sp_pricing_lambda_trigger${var.env}"
  schedule_expression = var.service_dynamo_cron
}

resource "aws_cloudwatch_event_target" "sp_sp_pricing_lambda" {
  count     = var.trigger_count
  rule      = aws_cloudwatch_event_rule.sp_sp_pricing_cloudwatch_rule[0].name
  target_id = "sp_sp_pricing_lambda_target${var.env}"
  arn       = aws_lambda_function.sp_sp_pricing.arn
}

# RDSTool_ODPricing_Download
data "archive_file" "rds_od_pricing_zip" {
  type        = "zip"
  source_file = "${path.module}/source/odpricing_rds_download.py"
  output_path = "${path.module}/output/rds_od_pricing.zip"
}

resource "aws_lambda_function" "rds_od_pricing" {
  description      = "Gets on demand rds pricies"
  filename         = "${path.module}/output/rds_od_pricing.zip"
  function_name    = "RDSTool_ODPricing_Download${var.env}"
  role             = aws_iam_role.iam_role_for_athena.arn
  handler          = "odpricing_rds_download.lambda_handler"
  source_code_hash = data.archive_file.rds_od_pricing_zip.output_base64sha256
  runtime          = "python3.8"
  memory_size      = "2688"
  timeout          = "600"

  environment {
    variables = {
      BUCKET_NAME = "${var.cur_bucket}${var.env}"
    }
  }

  tags = {
    "Team" = "FinOps"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch_rds_od_pricing" {
  count         = var.trigger_count
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rds_od_pricing.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rds_od_pricing_cloudwatch_rule[0].arn
}

resource "aws_cloudwatch_event_rule" "rds_od_pricing_cloudwatch_rule" {
  count               = var.trigger_count
  name                = "rds_od_pricing_lambda_trigger${var.env}"
  schedule_expression = var.service_dynamo_cron
}

resource "aws_cloudwatch_event_target" "rds_od_pricing_lambda" {
  count     = var.trigger_count
  rule      = aws_cloudwatch_event_rule.rds_od_pricing_cloudwatch_rule[0].name
  target_id = "rds_od_pricing_lambda_target${var.env}"
  arn       = aws_lambda_function.rds_od_pricing.arn
}

