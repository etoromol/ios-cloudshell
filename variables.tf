# variables.tf
# module ios-cloudshell
#
# Copyright (c) 2023 Eduardo Toro

variable "project" {
  description = "Cisco IOS-XE Software As A Service"
  type        = map(string)
  default = {
    tag = "ios-cloudshell"
  }
}

variable "zone" {
  description = "Dictionary of AWS Availability Zones"
  type        = map(string)
  default = {
    ue1  = "us-east-1"
    ue2  = "us-east-2"
    ue2a = "us-east-2a"
    uw1  = "us-west-1"
    uw2  = "us-west-2"
    uw1b = "us-west-1b"
    uw1c = "us-west-1c"
  }
}

variable "netblock" {
  description = "Network Block"
  type        = map(string)
  default = {
    default      = "0.0.0.0/0"
    network      = "10.0.0.0/16"
    cloud_subnet = "10.0.1.0/24"
  }
}

variable "vm_01" {
  description = <<EOT
                Cisco Cloud Services Router 1000V - Security Pkg. Max 
                Performance with IOS XE 16.9.2.
                EOT
  type        = map(any)
  default = {
    "name"              = "shell-16-09-02"
    "ami"               = "ami-02b1bc6d2e4aa01a6"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-east-2a"
  }
}

variable "vm_02" {
  description = <<EOT
                Cisco Cloud Services Router 1000V - Security Pkg. Max 
                Performance with IOS XE 16.12.5.
                EOT
  type        = map(any)
  default = {
    "name"              = "shell-16-12-05"
    "ami"               = "ami-0a51195a8716a60e4"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_03" {
  description = "Cisco Cloud Services Router 1000V - with IOS XE 17.3.3"
  type        = map(any)
  default = {
    "name"              = "shell-17-03-03"
    "ami"               = "ami-078986d887163741b"
    "instance_type"     = "t2.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_04" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.4.1b"
  type        = map(any)
  default = {
    "name"              = "shell-17-04-1b"
    "ami"               = "ami-0566d868d1b4458fd"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_05" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.05.1a"
  type        = map(any)
  default = {
    "name"              = "shell-17-05-1a"
    "ami"               = "ami-0b09ad6ef5daf67b1"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_06" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.06.3a"
  type        = map(any)
  default = {
    "name"              = "shell-17-06-3a"
    "ami"               = "ami-0337c5da21a9f9d28"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_07" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.07.1a"
  type        = map(any)
  default = {
    "name"              = "shell-17-07-1a"
    "ami"               = "ami-01a543c6a200d6dcd"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
  }
}

variable "vm_08" {
  description = "Cisco Catalyst 8000V - BYO with IOS XE 17.08.1a"
  type        = map(any)
  default = {
    "name"              = "shell-17-08-1a"
    "ami"               = "ami-0082690930bd41466"
    "instance_type"     = "t3.medium"
    "availability_zone" = "us-west-1b"
  }
}
