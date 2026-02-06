terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket         = "voting-app-tfstate-latinteam-saopaulo-20260206"
    key            = "voting-app/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-state-lock-latinteam-saopaulo"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}