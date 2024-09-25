output "instance_name_count" {
  value = aws_instance.exoterraform
}

output "instance_id" {
  value = [for instance in aws_instance.exoterraform:instance.id]
}

# output "instance_ips"{
#   value = [for i in aws_instance.exoterraform:i.public_ip]
# }