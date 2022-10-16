#output "key_pair" {
#  value       = module.key_pair.public_key_pem
#}
#

output "vpc_public_ip" {
  value       = module.ec2_instance.public_ip
}

##output "iam_role" {
#  value = module.iam_role.arn
#}
