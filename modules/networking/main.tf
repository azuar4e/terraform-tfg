resource "aws_vpc" "tfg-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tfg-vpc"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id            = aws_vpc.tfg-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.tfg-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name                              = "private-1a"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id            = aws_vpc.tfg-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-1b"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id            = aws_vpc.tfg-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name                              = "private-1b"
  }
}

# gateways
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.tfg-vpc.id
  tags = {
    Name = "main"
  }
}

resource "aws_eip" "main" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public-1a.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.main]
}

# route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tfg-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.tfg-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

# route table associations
resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-1b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private.id
}
