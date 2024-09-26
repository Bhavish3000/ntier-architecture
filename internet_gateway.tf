resource "aws_internet_gateway" "base" {
  count  = local.do_we_have_public_subnets ? 1 : 0
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "ntier_ing"
  }

}

