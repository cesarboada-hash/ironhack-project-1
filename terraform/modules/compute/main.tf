# Instance A - Vote + Result (Public Subnet - Bastion Host)
resource "aws_instance" "vote_result" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.vote_result_sg_id]

  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-frontend"
    Tier = "Application"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose git
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF
}

# Instance B - Redis + Worker (Private Subnet)
resource "aws_instance" "redis_worker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.private_subnet_redis_id
  vpc_security_group_ids = [var.redis_worker_sg_id]

  tags = {
    Name = "${var.project_name}-backend"
    Tier = "Backend"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF
}

# Instance C - PostgreSQL (Private Subnet)
resource "aws_instance" "postgres" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.private_subnet_db_id
  vpc_security_group_ids = [var.postgres_sg_id]

  tags = {
    Name = "${var.project_name}-database"
    Tier = "Database"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF
}