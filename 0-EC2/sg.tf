data "aws_vpc" "Hyd-DR-VPC" {
  id = "vpc-070e1fab88acfa846"
}

resource "aws_security_group" "NLB-SG" {
  name        = "NLB-SG"
  description = "Allow TCP inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.Hyd-DR-VPC.id

  tags = {
    Name = "NLB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.NLB-SG.id
  cidr_ipv4         = "10.2.5.27/32" # Mum OPEN VPN Priv IP
  from_port         = 2222
  ip_protocol       = "tcp"
  to_port           = 2222
}



resource "aws_vpc_security_group_ingress_rule" "allow_openvpn_ssh" {
  security_group_id = aws_security_group.NLB-SG.id
  cidr_ipv4         = "13.234.164.175/32" #OpenVPN Mum IP
  from_port         = 2121
  ip_protocol       = "tcp"
  to_port           = 2121
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.NLB-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}