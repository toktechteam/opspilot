output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3.bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "bucket_region" {
  description = "The region of the S3 bucket"
  value       = module.s3.bucket_region
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = module.s3.bucket_domain_name
}

output "versioning_enabled" {
  description = "Whether versioning is enabled on the bucket"
  value       = module.s3.versioning_enabled
}

output "encryption_type" {
  description = "The encryption type used for the bucket"
  value       = module.s3.encryption_type
}

output "public_access_blocked" {
  description = "Whether public access is blocked"
  value       = module.s3.public_access_blocked
}
