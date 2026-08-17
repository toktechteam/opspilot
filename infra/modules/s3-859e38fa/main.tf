resource "aws_s3_bucket" "main" {
  bucket_prefix = "${var.project_name}-"

  tags = merge(
    var.tags,
    {
      Project      = var.project_name
      ManagedBy    = "OpsPilot"
      Environment  = var.environment
      Owner        = var.owner
      CostCentre   = var.cost_centre
      ExpiresAt    = var.expires_at
      DeploymentId = var.deployment_id
    }
  )
}

resource "aws_s3_bucket_versioning" "main" {
  count  = var.versioning ? 1 : 0
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.encryption == "AES256" ? "AES256" : "aws:kms"
      kms_master_key_id = var.encryption == "aws:kms" ? var.kms_key_arn : null
    }
    bucket_key_enabled = var.encryption == "aws:kms" ? true : false
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  count  = var.block_public_access ? 1 : 0
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = var.lifecycle_expiration_days
    }

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
  }
}

resource "aws_s3_bucket_logging" "main" {
  count         = var.access_logging_bucket != null ? 1 : 0
  bucket        = aws_s3_bucket.main.id
  target_bucket = var.access_logging_bucket
  target_prefix = "${aws_s3_bucket.main.id}/"
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceTLSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
