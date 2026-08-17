provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project      = var.project_name
      ManagedBy    = "OpsPilot"
      Environment  = var.environment
      Owner        = var.owner
      CostCentre   = var.cost_centre
      ExpiresAt    = var.expires_at
      DeploymentId = var.deployment_id
    }
  }
}
