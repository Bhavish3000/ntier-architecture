vpc_info = {
  cidr_block           = "192.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "Ntier_vpc"
  }
}

public_subnet = [{
  cidr_block = "192.0.0.0/24"
  az         = "ap-south-1a"
  tags = {
    "Name" = "web-1"
  }
  },
  {
    cidr_block = "192.0.1.0/24"
    az         = "ap-south-1b"
    tags = {
      "Name" = "web-2"
    }
  }
]

private_subnet = [{
  cidr_block = "192.0.2.0/24"
  az         = "ap-south-1a"
  tags = {
    "Name" = "app-1"
  }
  },
  {
    cidr_block = "192.0.3.0/24"
    az         = "ap-south-1b"
    tags = {
      "Name" = "app-2"
    }
    }, {
    cidr_block = "192.0.4.0/24"
    az         = "ap-south-1c"
    tags = {
      "Name" = "db"
    }
}]


web_security_group = {
  Name        = "web_security_group"
  description = "This security group is to guard web layer"
  tags = {
    Name = "web_security_group"
  }
  inbound_rules = [{
    protocol    = "TCP"
    port        = 22
    source      = "0.0.0.0/0"
    description = "opening the ssh port for all which belongs to TCP protocol"

    },
    {
      protocol    = "TCP"
      port        = 80
      source      = "0.0.0.0/0"
      description = "opening http port for all"
    },
    {
      protocol    = "TCP"
      port        = 443
      source      = "0.0.0.0/0"
      description = "opening https port"
  }]
}

app_security_group = {
  Name        = "app_security_group"
  description = "application security_group"
  tags = {
    Name = "app_security_group"
  }
  inbound_rules = [{
    protocol    = "TCP"
    port        = 8000
    source      = "192.0.0.0/16"
    description = "opening http with in vpc"
  }]
}

db_security_group = {
  Name        = "db_security_group"
  description = "data base security_group"
  tags = {
    Name = "db_security_group"
  }
  inbound_rules = [{
    protocol    = "TCP"
    port        = 3306
    source      = "192.0.0.0/16"
    description = "opening sql with in vpc"
  }]
}

Ec2_instance = {
  ami                         = "ami-0522ab6e1ddcc7055"
  instance_type               = "t2.micro"
  key_name                    = "id-rsapub"
  associate_public_ip_address = false
}