module "im-module" {
  source        = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"
  project_id    = var.project_id
  deployment_id = "im-example-deployment"

  tf_repo_type           = "GITHUB"
  im_deployment_repo_uri = "https://github.com/josephdt12/infra-manager-git-example.git"
  im_deployment_ref      = "main"
  im_tf_variables        = "project_id=${var.project_id}"
  infra_manager_sa_roles = ["roles/compute.networkAdmin"]

  github_app_installation_id = "47236181"
  github_pat_secret          = "github-personal-token"
}

module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 9.0"
  project_id   = var.project_id
  network_name = "${var.network_name}-suffix"

  subnets = [
    {
      subnet_name   = "subnet-01"
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
