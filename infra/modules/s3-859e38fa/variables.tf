variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{1,63}$", var.project_name))
    error_message = "Project name must be lowercase alphanumeric with hyphens, max 63 characters."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{1,32}$", var.environment))
    error_message = "Environment must be lowercase alphanumeric with hyphens, max 32 characters."
  }
}

variable "owner" {
  description = "Owner of the resource for tagging and accountability"
  type        = string
  validation {
    condition     = length(var.owner) > 0 && length(var.owner) <= 128
    error_message = "Owner must be between 1 and 128 characters."
  }
}

variable "cost_centre" {
  description = "Cost centre for billing and cost allocation"
  type        = string
  validation {
    condition     = length(var.cost_centre) > 0 && length(var.cost_centre) <= 64
    error_message = "Cost centre must be between 1 and 64 characters."
  }
}

variable "expires_at" {
  description = "Expiration date for the resource in YYYY-MM-DD format"
  type        = string
  validation {
    condition     = can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.expires_at))
    error_message = "ExpiresAt must be in YYYY-MM-DD format."
  }
}

variable "deployment_id" {
  description = "Unique deployment identifier for tracking and auditing"
  type        = string
  validation {
    condition     = length(var.deployment_id) > 0 && length(var.deployment_id) <= 64
    error_message = "Deployment ID must be between 1 and 64 characters."
  }
}

variable "encryption" {
  description = "Encryption type: AES256 or aws:kms"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption)
    error_message = "Encryption must be either AES256 or aws:kms."
  }
}

variable "versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Block all public access to the bucket"
  type        = bool
  default     = true
}

variable "lifecycle_expiration_days" {
  description = "Number of days before objects expire"
  type        = number
  default     = 90
  validation {
    condition     = var.lifecycle_expiration_days > 0
    error_message = "Lifecycle expiration days must be greater than 0."
  }
}

variable "noncurrent_version_expiration_days" {
  description = "Number of days before noncurrent versions expire"
  type        = number
  default     = 30
  validation {
    condition     = var.noncurrent_version_expiration_days > 0
    error_message = "Noncurrent version expiration days must be greater than 0."
  }
}

variable "access_logging_bucket" {
  description = "S3 bucket for access logging (optional)"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption (required if encryption is aws:kms)"
  type        = string
  default     = null
  validation {
    condition     = var.encryption != "aws:kms" || var.kms_key_arn != null
    error_message = "kms_key_arn must be provided when encryption is set to aws:kms."
  }
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
