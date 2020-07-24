# Lambda RDS Unattached cleanup
```
The script schedules the review of any RDS that have been unattached, stop them then delete them.
This checks all regions
```

## Usage


module "aws_bas_lambda_scheduler" {
  source = "/aws_tf_rds_delete_unattached"
  sender_email = "example@hotmail.com"
}

Note:you must approve the address for sender before it can send emails

## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| rds\_stop\_instance\_cron| Rate expression for when to run the review of rds| string | `"cron(0 23 ? * FRI *)"` | no 
| rds\_terminate\_instance\_cron| Rate expression for when to run the terinate of rds| string | `"cron(0 23 ? * FRI *)"` | no 
| function\_prefix | Prefix for the name of the lambda created | string | `""` | no |
| region | region this will be deployed too | string | `""` | no | 
| reciver_email | What emails will be notified if there are rds with no connection | string | `""` | no | 
| sender_email | An email address that this lambda can send emails from | string | `""` | yes | 




## Testing 

Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
cd test
go mod init github.com/sg/sch
go test -v -run TestTerraformAws