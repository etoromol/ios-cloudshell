# main.tf
# module ios-cloudshell
#
# Copyright (c) 2023 Eduardo Toro

locals {
  vpc = "vpc-${var.project["tag"]}"
  igw = "igw-${var.project["tag"]}"
  seg = "seg-${var.project["tag"]}"
  snt = "snt-${var.project["tag"]}"
  rtb = "rtb-${var.project["tag"]}"
  nic = "nic-${var.project["tag"]}"
  eip = "eip-${var.project["tag"]}"
}

terraform {
  required_version = ">=1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.75.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.4"
    }
  }
}

provider "aws" {
  region = var.zone["uw1"]
}

resource "aws_vpc" "shell_vpc" {
  cidr_block       = var.netblock["network"]
  instance_tenancy = "default"
  tags = {
    Name = local.vpc
  }
}

resource "aws_internet_gateway" "shell_igw" {
  vpc_id = aws_vpc.shell_vpc.id
  tags = {
    Name = local.igw
  }
}

resource "aws_security_group" "shell_seg" {
  vpc_id = aws_vpc.shell_vpc.id
  ingress {
    description = "permit icmp from any"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.netblock["default"]]
  }
  ingress {
    description = "permit ssh from any"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.netblock["default"]]
  }
  ingress {
    description = "permit tls from any"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.netblock["default"]]
  }
  egress {
    description      = "permit any to any"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.netblock["default"]]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = local.seg
  }
}

resource "aws_subnet" "shell_snt" {
  vpc_id            = aws_vpc.shell_vpc.id
  cidr_block        = var.netblock["cloud_subnet"]
  availability_zone = var.zone["uw1b"]
  tags = {
    Name = local.snt
  }
}

resource "aws_route_table" "shell_rtb" {
  vpc_id = aws_vpc.shell_vpc.id
  route {
    cidr_block = var.netblock["default"]
    gateway_id = aws_internet_gateway.shell_igw.id
  }
  tags = {
    Name = local.rtb
  }
}

resource "aws_route_table_association" "shell_ass" {
  subnet_id      = aws_subnet.shell_snt.id
  route_table_id = aws_route_table.shell_rtb.id
}

resource "aws_network_interface" "shell_nic" {
  subnet_id       = aws_subnet.shell_snt.id
  security_groups = [aws_security_group.shell_seg.id]
  private_ips     = ["10.0.1.117"]
  tags = {
    Name = local.nic
  }
}

resource "aws_eip" "shell_eip" {
  depends_on                = [aws_internet_gateway.shell_igw]
  instance                  = aws_instance.cloudshell.id
  associate_with_private_ip = "10.0.1.117"
  vpc                       = true
  tags = {
    Name = local.eip
  }
}

resource "tls_private_key" "shell_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "shell_key_pair" {
  key_name   = "ios-cloudshell-key" # name of the key in aws.
  public_key = tls_private_key.shell_key.public_key_openssh
  provisioner "local-exec" { # copy the key in current directory.
    command = <<EOT
      echo '${tls_private_key.shell_key.private_key_pem}' > ./ios-cloudshell-key.pem
      chmod 400 ./ios-cloudshell-key.pem
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm ./ios-cloudshell-key.pem"
  }
}

resource "aws_instance" "cloudshell" {
  ami               = var.vm_06["ami"]
  instance_type     = var.vm_06["instance_type"]
  availability_zone = var.vm_06["availability_zone"]
  key_name          = aws_key_pair.shell_key_pair.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.shell_nic.id
  }
  tags = {
    Name = var.vm_06["name"]
  }
}
