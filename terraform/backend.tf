terraform {
  backend "s3" {
    bucket = "terra-07009"
    key    = "s3/east"
    region = "us-east-1"
  }
}
