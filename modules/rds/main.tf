resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  vpc_id = "vpc-06332d8e02576ef28"

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "rds_sg"
  }
}

resource "aws_db_instance" "postgres_rds"{
  identifier              = "postgres-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  allocated_storage       = 20
  publicly_accessible    = true
  storage_type           = "gp2"
  username               = var.rds_credential.username
  password               = var.rds_credential.password
  db_name                = "testDB"
  skip_final_snapshot    = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name

  tags = {
    Name = "PostgresRDS"
  }
}


resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = ["subnet-0be33d0a507d5f36f","subnet-0f7960c341e27e3aa"]

  tags = {
    Name = "DBSubnetGroup"
  }
}

