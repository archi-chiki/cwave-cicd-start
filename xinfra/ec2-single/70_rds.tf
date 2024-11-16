# RDS 서브넷 그룹
resource "aws_db_subnet_group" "istory_db_subnet_group" {
  name       = "istory-db-subnet-group"
  subnet_ids = [for subnet in aws_subnet.archi-chiki-vpc-public-subnet : subnet.id]

  tags = {
    Name = "istory DB subnet group"
  }
}

# RDS 파라미터 그룹
resource "aws_db_parameter_group" "istory_db_parameter_group" {
  family = "mysql8.0"
  name   = "istory-db-parameter-group"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }
}

# RDS 인스턴스
resource "aws_db_instance" "istory_db" {
  identifier           = "istory-db"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  
  db_name             = "archichiki"
  username           = "archichiki"
  password           = "abcd12345"  # 실제 운영에서는 AWS Secrets Manager 사용 권장
  
  db_subnet_group_name   = aws_db_subnet_group.istory_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.istory_rds_sg.id]
  
  parameter_group_name = aws_db_parameter_group.istory_db_parameter_group.name
  
  skip_final_snapshot = true  # 개발 환경에서만 사용. 운영에서는 false 권장
  
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"

  tags = {
    Name        = "istory"
    Environment = "Development"
  }
}

# RDS 엔드포인트 출력
output "rds_endpoint" {
  value       = aws_db_instance.istory_db.endpoint
  description = "The connection endpoint for the RDS instance"
}

output "rds_database_name" {
  value       = aws_db_instance.istory_db.db_name
  description = "The name of the default database"
}

output "rds_username" {
  value       = aws_db_instance.istory_db.username
  description = "The master username for the database"
}