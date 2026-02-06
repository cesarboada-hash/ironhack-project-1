# Security Group for Instance A (Vote + Result - Public - Bastion Host)
resource "aws_security_group" "vote_result_sg" {
  name        = "${var.project_name}-vote-result-sg"
  description = "Security group for Vote and Result applications (Public)"
  vpc_id      = var.vpc_id

  # HTTP
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH (solo desde tu IP para Bastion)
  ingress {
    description = "SSH from allowed IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_ips
  }

  # Vote app (puerto 5000)
  ingress {
    description = "Vote application"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Result app (puerto 5001)
  ingress {
    description = "Result application"
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound - permitir todo
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-vote-result-sg"
  }
}

# Security Group for Instance B (Redis + Worker - Private)
resource "aws_security_group" "redis_worker_sg" {
  name        = "${var.project_name}-redis-worker-sg"
  description = "Security group for Redis and Worker (Private)"
  vpc_id      = var.vpc_id

  # Redis port (6379) desde Vote/Result
  ingress {
    description     = "Redis from Vote/Result instances"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result_sg.id]
  }

  # SSH desde Bastion (Instance A)
  ingress {
    description     = "SSH from Bastion Host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result_sg.id]
  }

  # Outbound - permitir todo (necesario para que Worker conecte a PostgreSQL y actualizar paquetes)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-redis-worker-sg"
  }
}

# Security Group for Instance C (PostgreSQL - Private)
resource "aws_security_group" "postgres_sg" {
  name        = "${var.project_name}-postgres-sg"
  description = "Security group for PostgreSQL database (Private)"
  vpc_id      = var.vpc_id

  # PostgreSQL (5432) desde Worker
  ingress {
    description     = "PostgreSQL from Worker instance"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.redis_worker_sg.id]
  }

  # PostgreSQL (5432) desde Vote/Result (si es necesario acceso directo)
  ingress {
    description     = "PostgreSQL from Vote/Result instances"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result_sg.id]
  }

  # SSH desde Bastion (Instance A)
  ingress {
    description     = "SSH from Bastion Host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_result_sg.id]
  }

  # Outbound - permitir todo (para actualizaciones, instalación de paquetes)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-postgres-sg"
  }
}