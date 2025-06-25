terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"

}

# Create a VPC
resource "aws_vpc" "IntelliPaat-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
        Name = "IntelliPaat-VPC"
  }
}

# Create Subnet

resource "aws_subnet" "IntelliPaat-Subnet1" {
    vpc_id = aws_vpc.IntelliPaat-VPC.id
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "IntelliPaat-Subnet1"
    }
}

# Create Internet Gateway

resource "aws_internet_gateway" "IntelliPaat-IntGW" {
    vpc_id = aws_vpc.IntelliPaat-VPC.id

    tags = {
        Name = "IntelliPaat-IntGW"
    }
}

resource "aws_security_group" "intellipaat-sg" {
  name        = "intellipaat-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.IntelliPaat-VPC.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "intellipaat-sg"
  }
}
