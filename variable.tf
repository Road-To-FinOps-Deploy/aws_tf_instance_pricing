variable "pricing_cron" {
  description = "interval of time to trigger lambda function"
  default     = "cron(0 6 ? * MON *)"
}

variable "env" {
  description = "name of enviroment"
  default     = ""
}

variable "output_bucket" {
  description = "name bucket you want this data to be stroed in"
}