variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "voting-app"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_redis_cidr" {
  description = "CIDR block for private subnet (Redis/Worker)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_db_cidr" {
  description = "CIDR block for private subnet (PostgreSQL)"
  type        = string
  default     = "10.0.3.0/24"
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "sa-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
}

variable "allowed_ssh_ips" {
  description = "List of IPs allowed for SSH access (format: [\"x.x.x.x/32\", \"y.y.y.y/32\"])"
  type        = list(string)
<<<<<<< HEAD
}
variable "alert_email" {
  description = "Email to receive CloudWatch alerts"
  type        = string
}
=======
}
>>>>>>> origin/main
