module "s3" {
  source = "../../../../modules/s3-859e38fa"

  project_name                       = var.project_name
  environment                        = var.environment
  owner                              = var.owner
  cost_centre                        = var.cost_centre
  expires_at                         = var.expires_at
  deployment_id                      = var.deployment_id
  encryption                         = var.encryption
  versioning                         = var.versioning
  block_public_access                = var.block_public_access
  lifecycle_expiration_days          = var.lifecycle_expiration_days
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  access_logging_bucket              = var.access_logging_bucket
  kms_key_arn                        = var.kms_key_arn
  tags                               = var.tags
}
