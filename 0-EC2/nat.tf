############### Public subnet in which the NAT is created
data "aws_subnet" "Public-Subnet-WEB-2a" {
  id = "subnet-002dd2296913605e1"
}

data "aws_subnet" "Public-Subnet-WEB-2b" {
  id = "subnet-0d7ced973c82a56d3"
}

############### Private Route tables for EC2 and EKS nodes throught NAT Gateway

data "aws_route_table""PVT-APP-2a" {
    route_table_id = "rtb-06a5b3a645162ed4f"
}

data "aws_route_table" "PVT-APP-2b" {
    route_table_id = "rtb-0a4c06280a04113b7"
}

data "aws_route_table" "PVT-APP-2c" {
    route_table_id = "rtb-00c99672a21b13410"
}

data "aws_route_table" "PVT-DB-2a" {
    subnet_id = "subnet-04dbed4a286311d5b"
}
############### Private APP Subnetes for EC2 and EKS nodes

data "aws_subnet" "PVT-APP-2a" {
    id = "subnet-0faa9e5cc4c63ce4b"
}

data "aws_subnet" "PVT-APP-2b" {
    id = "subnet-0d12d13c2263e89e3"
}
data "aws_subnet" "PVT-APP-2c" {
    id = "subnet-0ded724ce358afba8"
}

###### Single NAT gateway for all subnets the EIP is reservers and will be reused
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


resource "aws_route" "DB-2a-PUB-Route" {
  route_table_id = data.aws_route_table.PVT-DB-2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT-GW-PUB.id 
}