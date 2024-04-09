module "im_workspace" {
  source = "terraform-google-modules/bootstrap/google//modules/im_cloudbuild_workspace"

  project_id    = var.project_id
  deployment_id = "im-example-deployment"

  tf_repo_type           = "GITHUB"
  im_deployment_repo_uri = var.repository_url
  im_deployment_ref      = "main"
  infra_manager_sa_roles = ["roles/compute.networkAdmin"]
  tf_version             = "1.5.7"

  // Found in the URL of your Cloud Build GitHub app configuration settings
  // https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_host_programmatically
  github_app_installation_id   = "47236181"
  github_pat_secret            = "github-personal-token"
}

module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 9.0"
  project_id   = var.project_id
  network_name = "${var.network_name}"

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
