variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "allowed_ssh_ips" {
  description = "List of Ips allowed for SSH access"
  type        = list(string)
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}