terraform {
  backend "s3" {
    bucket = "federated-production-forge-data-engineers-cocosurf-tfstate"
    key    = "production/cocosurf/terraform.tfstate"
    region = "eu-central-1"
  }
}