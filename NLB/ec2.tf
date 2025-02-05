# data "aws_instance" "SFTP-Linux" {
#   instance_id = "i-09d1211619ded0651"
# }

data "aws_security_group" "SFTP-Linux-SG" {
    id = "sg-0bff70fa7fcef1a0c"
}

import {
  id = data.aws_instance.SFTP-Linux.id
  to = aws_instance.SFTP-Linux
}

resource "aws_instance" "SFTP-Linux" {
    ami                     = "ami-050dd27578207ff37"
    subnet_id               = "subnet-0faa9e5cc4c63ce4b"
    instance_type           = "t3.large"
    key_name = "SystemX-SFTP-Prod-HYD-Key-Pair"
    associate_public_ip_address = false
    root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
    volume_size = 50
    volume_type = "gp3"
    }
    private_ip = "10.10.6.147"
    vpc_security_group_ids =  [data.aws_security_group.SFTP-Linux-SG.id]
    tags = {
      Name = "SystemX-SFTP-Prod-HYD"
    }
}

resource "aws_instance" "SFTP-Linux" {
    ami                     = "ami-050dd27578207ff37"
    subnet_id               = "subnet-0faa9e5cc4c63ce4b"
    instance_type           = "t3.large"
    key_name = "SystemX-SFTP-Prod-HYD-Key-Pair"
    associate_public_ip_address = false
    root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
    volume_size = 50
    volume_type = "gp3"
    }
    private_ip = "10.10.6.147"
    vpc_security_group_ids =  [data.aws_security_group.SFTP-Linux-SG.id]
    tags = {
      Name = "SystemX-SFTP-Prod-HYD"
    }
}

resource "aws_instance" "SFTP-Windows" {
    ami                     = "ami-0db9518b7cc4d3333"
    subnet_id               = "subnet-0faa9e5cc4c63ce4b"
    instance_type           = "t3.large"
    key_name = "SystemX-SFTP-Prod-HYD-Key-Pair"
    associate_public_ip_address = false
    root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
    volume_size = 50
    volume_type = "gp3"
    }
    private_ip = "10.10.6.147"
    vpc_security_group_ids =  [data.aws_security_group.SFTP-Linux-SG.id]
    tags = {
      Name = "SystemX-SFTP-Prod-HYD"
    }
}