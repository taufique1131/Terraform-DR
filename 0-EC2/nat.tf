data "aws_subnet" "Public-Subnet-WEB-2a" {
  id = "subnet-002dd2296913605e1"
}

data "aws_route_table""PVT-APP-2a" {
    route_table_id = "rtb-06a5b3a645162ed4f"
}
#subnet-0faa9e5cc4c63ce4b

data "aws_route_table" "PVT-APP-2b" {
    route_table_id = "rtb-0a4c06280a04113b7"
}

data "aws_route_table" "PVT-APP-2c" {
    route_table_id = "rtb-00c99672a21b13410"
}

resource "aws_nat_gateway" "NAT-GW-PUB" {
  allocation_id = "eipalloc-08293b78093d71f90"
  subnet_id     = data.aws_subnet.Public-Subnet-WEB-2a.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route" "APP-2a-PUB-Route" {
  route_table_id = data.aws_route_table.PVT-APP-2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT-GW-PUB.id 
}

resource "aws_route" "APP-2b-PUB-Route" {
  route_table_id = data.aws_route_table.PVT-APP-2b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT-GW-PUB.id 
}

resource "aws_route" "APP-2c-PUB-Route" {
  route_table_id = data.aws_route_table.PVT-APP-2c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT-GW-PUB.id 
}