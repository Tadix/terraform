

resource "aws_security_group" "lb_sg" {
  name        = "lb_security_group"
  vpc_id = "vpc-06332d8e02576ef28"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sg"
  }
}


resource "aws_lb_target_group" "lb_target_group" {
  name     = "aws-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = "vpc-06332d8e02576ef28"
}


resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  count=2
  target_id =var.instance_id[count.index]
  target_group_arn = aws_lb_target_group.lb_target_group.arn
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb_cluster.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_listener_rule" "listener_rule_1" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}




resource "aws_lb" "lb_cluster" {
  name               = "lbcluster"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-0be33d0a507d5f36f","subnet-0f7960c341e27e3aa"]
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}