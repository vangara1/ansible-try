resource "tls_private_key" "wave-key" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name = var.NAME
  public_key = trimspace(tls_private_key.wave-key.public_key_openssh)
}



resource "null_resource" "key-wave" {
  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.wave-key.private_key_pem}' > ./'${var.NAME}'.pem
      sudo chmod 400 ./'${var.NAME}'.pem
    EOT
  }
}
