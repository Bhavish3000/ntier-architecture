resource "aws_security_group" "web" {
  name   = var.web_security_group.Name
  vpc_id = aws_vpc.base.id
  tags = {
    Name = var.web_security_group.Name
  }
  description = var.web_security_group.description

  depends_on = [aws_vpc.base]

}

resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.inbound_rules)
  security_group_id = aws_security_group.web.id
  ip_protocol       = var.web_security_group.inbound_rules[count.index].protocol
  cidr_ipv4         = var.web_security_group.inbound_rules[count.index].source
  from_port         = var.web_security_group.inbound_rules[count.index].port
  to_port           = var.web_security_group.inbound_rules[count.index].port
  description       = var.web_security_group.inbound_rules[count.index].description
  depends_on        = [aws_security_group.web]
}

resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  depends_on        = [aws_security_group.web]
}

resource "aws_security_group" "app" {
  name        = var.app_security_group.Name
  vpc_id      = aws_vpc.base.id
  description = var.app_security_group.description
  tags = {
    Name = var.app_security_group.Name

  }
  depends_on = [aws_vpc.base]

}
resource "aws_vpc_security_group_ingress_rule" "app" {
  count             = length(var.app_security_group.inbound_rules)
  security_group_id = aws_security_group.app.id
  ip_protocol       = var.app_security_group.inbound_rules[0].protocol
  cidr_ipv4         = var.app_security_group.inbound_rules[0].source
  from_port         = var.app_security_group.inbound_rules[0].port
  to_port           = var.app_security_group.inbound_rules[0].port
  description       = var.app_security_group.inbound_rules[0].description
  depends_on        = [aws_security_group.app]
}

resource "aws_vpc_security_group_egress_rule" "app" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  depends_on        = [aws_security_group.app]
}

resource "aws_security_group" "db" {
  name        = var.db_security_group.Name
  vpc_id      = aws_vpc.base.id
  description = var.db_security_group.description
  tags = {
    Name = var.db_security_group.Name

  }
  depends_on = [aws_vpc.base]
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  count             = length(var.db_security_group.inbound_rules)
  security_group_id = aws_security_group.db.id
  ip_protocol       = var.db_security_group.inbound_rules[0].protocol
  cidr_ipv4         = var.db_security_group.inbound_rules[0].source
  from_port         = var.db_security_group.inbound_rules[0].port
  to_port           = var.db_security_group.inbound_rules[0].port
  description       = var.db_security_group.inbound_rules[0].description
  depends_on        = [aws_security_group.db]
}

resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  depends_on        = [aws_security_group.db]
}