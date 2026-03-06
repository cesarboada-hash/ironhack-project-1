variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "private_subnet_redis_cidr" {
  description = "CIDR block for private subnet (Redis/Worker)"
  type        = string
}

variable "private_subnet_db_cidr" {
  description = "CIDR block for private subnet (PostgreSQL)"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}