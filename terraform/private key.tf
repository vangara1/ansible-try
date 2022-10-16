resource "aws_key_pair" "must-key" {
  key_name = "must.pem"
  public_key = file(var.must-key)
}