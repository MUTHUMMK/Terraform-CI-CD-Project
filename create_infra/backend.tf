terraform {
  backend "s3" {
    bucket         = "terraform-vpc-alb-statefile"
    key            = "vpc-state-tf"         # Change this to a unique name for each configuration
    region         = "ap-south-1"           # Change to your desired AWS region
    encrypt        = true                   # Set to true if you want to encrypt the state file
    dynamodb_table = "dynamoDB-statelocktf" # Optional: Use DynamoDB for locking
  }
}