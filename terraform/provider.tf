provider "aws" {
  region  = "ap-northeast-2"
  profile = "diary-for-f"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "diary-for-f-tf-state-bucket"
    key          = "terraform/state"
    region       = "ap-northeast-2"
    use_lockfile = true
    profile      = "diary-for-f"

  }
}
