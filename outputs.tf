# outputs.tf
# module ios-cloudshell
#
# Copyright (c) 2023 Eduardo Toro

output "shell-zone" {
  value = aws_instance.cloudshell.availability_zone
}

output "shell-tier" {
  value = aws_instance.cloudshell.instance_type
}

output "shell-ip" {
  value = aws_eip.shell_eip.public_ip
}
