provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}