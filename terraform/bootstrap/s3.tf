resource "aws_s3_bucket" "ny_taxi_terraform_state" {
  bucket = "ny-taxi-terraform-state-${var.account_id}"

  tags = {
    Name = "ny-taxi-terraform-state-${var.account_id}"
  }
}

resource "aws_s3_bucket_versioning" "ny_taxi_bucket_versioning" {
  bucket = aws_s3_bucket.ny_taxi_terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "ny_taxi_block_public_access" {
  bucket = aws_s3_bucket.ny_taxi_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ny_taxi_bucket_encrypt" {
  bucket = aws_s3_bucket.ny_taxi_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}