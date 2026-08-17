output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_region" {
  description = "The region of the S3 bucket"
  value       = aws_s3_bucket.main.region
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.main.bucket_regional_domain_name
}

output "versioning_enabled" {
  description = "Whether versioning is enabled on the bucket"
  value       = var.versioning
}

output "encryption_type" {
  description = "The encryption type used for the bucket"
  value       = var.encryption
}

output "public_access_blocked" {
  description = "Whether public access is blocked"
  value       = var.block_public_access
}
