# VPC 생성
resource "aws_vpc" "archi-chiki-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "archi-chiki-vpc"
  }
}
# 퍼블릭 서브넷 
resource "aws_subnet" "archi-chiki-vpc-public-subnet" {
  for_each = {
    a = { cidr = "10.0.1.0/24", az = "ap-northeast-2a" }
    b = { cidr = "10.0.2.0/24", az = "ap-northeast-2b" }
    c = { cidr = "10.0.3.0/24", az = "ap-northeast-2c" }
    d = { cidr = "10.0.4.0/24", az = "ap-northeast-2d" }
  }

  vpc_id                  = aws_vpc.archi-chiki-vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "archi-chiki-vpc-public-subnet-${each.key}"
  }
}

# 인터넷 게이트웨이 생성
resource "aws_internet_gateway" "archi-chiki-igw" {
  vpc_id = aws_vpc.archi-chiki-vpc.id

  tags = {
    Name = "archi-chiki-igw"
  }
}

# 라우팅 테이블 생성
resource "aws_route_table" "archi-chiki-vpc-public-rt" {
  vpc_id = aws_vpc.archi-chiki-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.archi-chiki-igw.id
  }

  tags = {
    Name = "archi-chiki-vpc-public-rt"
    
  }
}

resource "aws_route_table_association" "archi-chiki-vpc-public-rt" {
  for_each = {
    a = aws_subnet.archi-chiki-vpc-public-subnet["a"].id
    b = aws_subnet.archi-chiki-vpc-public-subnet["b"].id
    c = aws_subnet.archi-chiki-vpc-public-subnet["c"].id
    d = aws_subnet.archi-chiki-vpc-public-subnet["d"].id
  }
  
  subnet_id      = each.value
  route_table_id = aws_route_table.archi-chiki-vpc-public-rt.id
}
