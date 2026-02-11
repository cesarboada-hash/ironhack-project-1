variable "project_name" {
  description = "Project name"
  type        = string
}

variable "alert_email" {
  description = "Email to receive CloudWatch alerts"
  type        = string
}

variable "frontend_instance_id" {
  description = "Frontend instance ID"
  type        = string
}

variable "backend_instance_id" {
  description = "Backend instance ID"
  type        = string
}

variable "db_instance_id" {
  description = "Database instance ID"
  type        = string
}

