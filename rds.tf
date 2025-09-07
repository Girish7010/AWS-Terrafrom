# DB Subnet Group (required so RDS knows where to launch)
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.private[*].id   # uses private subnets from vpc.tf

  tags = {
    Name = "db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "app_db" {
  identifier              = "app-db"
  allocated_storage       = 20
  max_allocated_storage   = 100                # allow autoscaling storage
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  db_name                 = var.db_name        # ✅ MySQL/Postgres requires db_name, not name
  username                = var.db_user
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  multi_az                = false              # set true if you want HA
  publicly_accessible     = false              # DB stays private
  skip_final_snapshot     = true

  tags = {
    Name = "app-db"
  }
}
