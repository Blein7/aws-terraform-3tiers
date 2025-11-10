terraform {
  backend "s3" {
    bucket         = "my-backend-tf-bucket1787"
    key            = "3-tier-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table17"
    encrypt        = true
  }
}
