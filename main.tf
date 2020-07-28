
#


module "aws_bas_lambda_scheduler" {
  source = "github.com/Road-To-FinOps-Deploy/aws_tf_ebs_resize.git"
  alarm_email = "stephanie.gooch@kpmg.com"
  InstanceId = "i-0a2483802a3f16aea"
}