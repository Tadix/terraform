

resource "aws_security_group" "lb_sg" {
  name        = "lb_security_group"

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


# resource "aws_lb_target_group" "lb_target_group_1" {
#   name     = "aws-lb-tg-1"
#   port     = 80
#   protocol = "HTTP"
#   target_type = "instance"
#   vpc_id = "vpc-06332d8e02576ef28"
# }
#
# resource "aws_lb_target_group" "lb_target_group_2" {
#   name     = "aws-lb-tg-2"
#   port     = 80
#   protocol = "HTTP"
#   target_type = "instance"
#   vpc_id = "vpc-06332d8e02576ef28"
# }
#
# resource "aws_lb_target_group_attachment" "lb_target_group_attachment_1" {
#   target_id =var.instance_id[0]
#   target_group_arn = aws_lb_target_group.lb_target_group_1.arn
# }
#
# resource "aws_lb_target_group_attachment" "lb_target_group_attachment_2" {
#   target_id =var.instance_id[1]
#   target_group_arn = aws_lb_target_group.lb_target_group_2.arn
# }
#
#
# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = aws_lb.lb_cluster.arn
#   port              = "80"
#   protocol          = "HTTP"
#
#   default_action {
#     type =  "redirect"
# #     type             = "redirect"
# #     redirect {
# #       port        = "443"
# #       protocol    = "HTTPS"
# #       status_code = "HTTP_301"
# #     }
#   }
# }
#
# resource "aws_lb_listener_rule" "listener_rule_1" {
#   listener_arn = aws_lb_listener.listener.arn
#   priority     = 100
#   condition {
#
#   }
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.lb_target_group_1.arn
#   }
# }
#
#
# resource "aws_lb_listener_rule" "listener_rule_2" {
#   listener_arn = aws_lb_listener.listener.arn
#   priority     = 90
#   condition {
#
#   }
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.lb_target_group_2.arn
#   }
# }



resource "aws_lb" "lb_cluster" {
  name               = "lbcluster"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-0be33d0a507d5f36f","subnet-0d7f62d64827d1277"]
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}