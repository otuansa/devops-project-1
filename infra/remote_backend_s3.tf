terraform {
  backend "s3" {
    bucket = "techteam-help"
    key    = "devops-project-1/terraform.tfstate"
    region = "eu-central-1"
  }
}
