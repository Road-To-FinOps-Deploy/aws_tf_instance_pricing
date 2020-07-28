# Lambda Instance Pricing
```
The lamdab is to pull Pricing data for EC2 on demand and SP plus RDS On Demand.
This comes from the wellarchitectedlabs - 200_pricing_model_analysis but just as a terraformed version.
```

## Usage

```
module "aws_tf_ec2_upgrade_reccomendation" {
  source = "/aws_tf_rds_delete_unattached"
  output_bucket = "mys3bucketname"
}
```

Once deployed you can use the athena to setup view from the crawlers to get the data in a nicer format.
NOTE!!  You must follow step 31 of this guide https://wellarchitectedlabs.com/cost/200_labs/200_pricing_model_analysis/1_pricing_sources/ to ensure the table is correct


## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| output_bucket| Bucket name for the data to be loaded to| string | `""` | yes
| pricing\_cron| Rate expression for when to run the review of rds| string | `"cron(0 6 ? * MON *)"` | no 
| env| Name of envirment| string | `""` | no




## Testing 

Configure your AWS credentials using one of the [supported methods for AWS CLI
   tools](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html), such as setting the
   `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. If you're using the `~/.aws/config` file for profiles then export `AWS_SDK_LOAD_CONFIG` as "True".
1. Install [Terraform](https://www.terraform.io/) and make sure it's on your `PATH`.
1. Install [Golang](https://golang.org/) and make sure this code is checked out into your `GOPATH`.
cd test
go mod init github.com/sg/sch
go test -v -run TestTerraformAws