resource "aws_instance" "web" {
  ami                         = var.Ec2_instance.ami
  instance_type               = var.Ec2_instance.instance_type
  key_name                    = var.Ec2_instance.key_name
  associate_public_ip_address = var.Ec2_instance.associate_public_ip_address
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.web.id]

}