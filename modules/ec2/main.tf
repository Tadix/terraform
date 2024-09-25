resource "aws_security_group" "exo_secur_group" {
  name        = "exo_secur_group"
  description = "allow ssh on 22 & http on port 80"
#   vpc_id = "vpc-06332d8e02576ef28"


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "exoterraform" {
  count = var.ec2_instance_number
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  subnet_id = var.subnet_ids[count.index]
  iam_instance_profile = var.profile
  tags = {
    Name = "exoterraform${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.exo_secur_group.id]

  user_data = templatefile("./modules/ec2/bash_script.tpl",{
    instance_name_count="exoterraform${count.index}"
  })
}