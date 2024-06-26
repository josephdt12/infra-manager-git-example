module "im-module" {
  source        = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  project_id    = var.project_id
  deployment_id = var.deployment_id

  im_deployment_repo_uri = var.im_deployment_repo_uri
  im_deployment_ref      = var.im_deployment_ref
  im_tf_variables        = "project_id=${var.project_id}"
  tf_version             = "1.5.7"

  github_app_installation_id = var.github_app_installation_id
  github_pat_secret          = var.github_pat_secret
}

module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 9.1"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = "subnet-01-suffix"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name               = "subnet-03"
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = "us-west1"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter   = "false"
    }
  ]
}
