variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "deployment_id" {
  description = "Deployment ID"
  type        = string
}

variable "im_deployment_repo_uri" {
  description = "Repository URI"
  type        = string
}

variable "im_deployment_ref" {
  description = "Branch"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub CB App"
  type        = string
}

variable "github_pat_secret" {
  description = "Secret ID"
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
  default     = "my-example-network"
}
