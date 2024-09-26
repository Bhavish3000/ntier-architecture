# creating public route table

resource "aws_route_table" "public" {
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public_rt"
  }
  depends_on = [aws_vpc.base]

}

#creating private route table

resource "aws_route_table" "base" {
  count  = local.do_we_have_private_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private_rt"
  }
  depends_on = [aws_vpc.base]
}

#Assocaiate public subnets with public route table

resource "aws_route_table_association" "base" {
  count          = length(var.public_subnet)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public[count.index].id
}

#Assocaiate private subnets with private route table

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  route_table_id = aws_route_table.base[0].id
  subnet_id      = aws_subnet.private[count.index].id
}

resource "aws_route" "internet" {
  count                  = local.do_we_have_public_subnets ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.base[0].id

}