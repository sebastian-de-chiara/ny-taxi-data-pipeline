variable "aws_region" {
  type        = string
  description = "Region used"
  default     = "ap-southeast-2"
}

variable "account_id" {
  type        = string
  description = "Account ID for the AWS IAM User"
  default     = "013453151250"
}

variable "project_name" {
  type        = string
  description = "Name for the project"
  default     = "ny-taxi"
}