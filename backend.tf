terraform {
  backend "s3" {
    bucket  = "penny-bucket-577906137810"
    key     = "upgrade/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
    profile = "penny"
  }
}


provider "aws" {
  region  = "eu-west-1"
  profile = "penny"
}
