resource "aws_lb" "Main-NLB" {
  name               = "Main-NLB-Hyd"
  internal           = false
  load_balancer_type = "network"
#   subnets            = [data.aws_subnet.Public-Subnet-WEB-2a.id, data.aws_subnet.Public-Subnet-WEB-2b.id]
  subnet_mapping {
    subnet_id = data.aws_subnet.Public-Subnet-WEB-2a.id
    allocation_id = "eipalloc-083f5ff9868f31480"
  }
  subnet_mapping {
    subnet_id = data.aws_subnet.Public-Subnet-WEB-2b.id
  }


  enable_deletion_protection = false
  enable_cross_zone_load_balancing = false
  enforce_security_group_inbound_rules_on_private_link_traffic = "on"
  ip_address_type = "ipv4"
  security_groups = [aws_security_group.NLB-SG.id]

  tags = {
    Environment = "DR"
    Owner = "Suresh Bedekar"
  }
}

resource "aws_lb_target_group" "SFTP-Linux-TG" {
  name = "SFTP-Linux-TG"
  port = 22
  protocol = "TCP"
  target_type = "instance"
  vpc_id = data.aws_vpc.Hyd-DR-VPC.id
  health_check {
    enabled = true
    port = "traffic-port"
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "SFTP-Linux-TG-attachment" {
  target_group_arn = aws_lb_target_group.SFTP-Linux-TG.arn
  target_id        = aws_instance.SFTP-Linux.id
  port             = 22
}


resource "aws_lb_listener" "SFTP-Linux" {
  load_balancer_arn = aws_lb.Main-NLB.arn
  port = "2121"
  protocol = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.SFTP-Linux-TG.arn
    type = "forward"
  }
}

resource "aws_lb_target_group" "SFTP-Windows-TG" {
  name = "SFTP-Windows-TG"
  port = 22
  protocol = "TCP"
  target_type = "instance"
  vpc_id = data.aws_vpc.Hyd-DR-VPC.id
  health_check {
    enabled = true
    port = "traffic-port"
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "SFTP-Windows-TG-attachment" {
  target_group_arn = aws_lb_target_group.SFTP-Windows-TG.arn
  target_id        = aws_instance.SFTP-Windows.id
  port             = 22
}


resource "aws_lb_listener" "SFTP-Windows" {
  load_balancer_arn = aws_lb.Main-NLB.arn
  port = "3131"
  protocol = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.SFTP-Windows-TG.arn
    type = "forward"
  }
}