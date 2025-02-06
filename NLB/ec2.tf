

data "aws_security_group" "SFTP-Linux-SG" {
    id = "sg-0bff70fa7fcef1a0c"
}

data "aws_security_group" "SFTP-Windows-SG" {
    id = "sg-0ede64e6fce087f9f"
}

data "aws_security_group" "Inward-Outward" {
    id = "sg-081db4aedca4f15ef"
}

data "aws_security_group" "Payment-Server" {
    id = "sg-0fa0b72144526df0d"
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
    subnet_id               = "subnet-0d12d13c2263e89e3"
    instance_type           = "t3.large"
    key_name = "Systemx-Windows-Server-SFTP-PROD-HYD-Key-Pair"
    associate_public_ip_address = false
    root_block_device {
      delete_on_termination = true
      encrypted = true
      kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
      volume_size = 75
      volume_type = "gp3"
    }
    private_ip = "10.10.8.167"
    vpc_security_group_ids =  [data.aws_security_group.SFTP-Windows-SG.id]
    tags = {
      Name = "SystemX-Windows-SFTP-Prod-HYD"
    }
}

output "Windows_password" {
  description = "windows pass"
  value = aws_instance.SFTP-Windows.password_data
}

resource "aws_instance" "Inward-Outward" {
    ami                     = "ami-0f899d5bc99fa8143"
    subnet_id               = "subnet-0faa9e5cc4c63ce4b"
    instance_type           = "t3.large"
    key_name = "inward-outward-hyd-dr-key"
    associate_public_ip_address = false
    root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
    volume_size = 70
    volume_type = "gp3"
    }
    private_ip = "10.10.7.22"
    vpc_security_group_ids =  [data.aws_security_group.Inward-Outward.id]
    tags = {
      Name = "SystemX-Inward-Outward-Server-HYD"
    }
}

resource "aws_instance" "Payment-Server" {
    ami                     = "ami-019c3b5a88f6ca118"
    subnet_id               = "subnet-0d12d13c2263e89e3"
    instance_type           = "c6a.large"
    key_name = "SystemX-Payment-Server-Prod-HYD-Key-Pair"
    associate_public_ip_address = false
    root_block_device {
    delete_on_termination = true
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-south-2:609459977430:key/mrk-52b7fad95ecb4750ba0764abc76f2f7d"
    volume_size = 30
    volume_type = "gp3"
    }
    private_ip = "10.10.8.90"
    vpc_security_group_ids =  [data.aws_security_group.Payment-Server.id]
    tags = {
      Name = "SystemX-Payment-Server-Prod-HYD"
    }
}
