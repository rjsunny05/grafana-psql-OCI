terraform {
  backend "s3" {
    bucket  = "my-buckt-rj05"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}