variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "private_subnet_redis_id" {
  description = "Private subnet ID for Redis/Worker"
  type        = string
}

variable "private_subnet_db_id" {
  description = "Private subnet ID for PostgreSQL"
  type        = string
}

variable "vote_result_sg_id" {
  description = "Security group ID for Vote/Result instance"
  type        = string
}

variable "redis_worker_sg_id" {
  description = "Security group ID for Redis/Worker instance"
  type        = string
}

variable "postgres_sg_id" {
  description = "Security group ID for PostgreSQL instance"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}