provider "aws" {
    region = "us-east-1"
  
}

terraform {
  backend "s3" {
    bucket = "reddit-terraform-state"
    key = "statefile"
    region = "us-east-1"
    dynamodb_table = "reddit-db"
    
  }
}
