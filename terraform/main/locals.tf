locals {
  project_name = "ny-taxi"
  account_id   = data.aws_caller_identity.current.account_id

  environments = {
    dev = {
      retention_days = 1
    }
    test = {
      retention_days = 3
    }
    prod = {
      retention_days = 7
    }
  }
}

data "aws_caller_identity" "current" {}
