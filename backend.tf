terraform {
  backend "s3" {
    bucket         = "my-backend-tf-bucket17"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table17"
    encrypt        = true
  }
}
