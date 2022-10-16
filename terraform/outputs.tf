output "key_pair" {
  value       = module.key_pair.public_key_pem
}


#output "vpc_public_subnets" {
#  value       = module.vpc.public_subnets
#}
#
##output "iam_role" {
#  value = module.iam_role.arn
#}
