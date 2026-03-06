output "vote_result_public_ip" {
  description = "Public IP of Vote/Result instance (Bastion)"
  value       = module.compute.vote_result_public_ip
}

output "redis_worker_private_ip" {
  description = "Private IP of Redis/Worker instance"
  value       = module.compute.redis_worker_private_ip
}

output "postgres_private_ip" {
  description = "Private IP of PostgreSQL instance"
  value       = module.compute.postgres_private_ip
}

output "ssh_command_bastion" {
  description = "SSH command to connect to Bastion host"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${module.compute.vote_result_public_ip}"
}