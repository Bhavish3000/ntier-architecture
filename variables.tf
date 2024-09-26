variable "vpc_info" {
  type = object({
    cidr_block           = string
    enable_dns_hostnames = bool
    tags                 = map(string)
  })
  description = "network vpc"

}

variable "public_subnet" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)
  }))
  description = "public subnets of the vpc to host the web servers"

}

variable "private_subnet" {
  type = list(object({
    cidr_block = string
    az         = string
    tags       = map(string)
  }))
  description = "private subnets of the vpc to host the other servers"

}

variable "web_security_group" {
  type = object({
    Name        = string
    description = string
    tags        = map(string)
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))


  })

}

variable "app_security_group" {
  type = object({
    Name        = string
    description = string
    tags        = map(string)
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))
  })

}

variable "db_security_group" {
  type = object({
    Name        = string
    description = string
    tags        = map(string)
    inbound_rules = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
    }))
  })

}

variable "Ec2_instance" {
  type = object({
    ami                         = string
    instance_type               = string
    key_name                    = string
    associate_public_ip_address = bool
  })

}