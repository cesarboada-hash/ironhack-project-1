output "vote_result_public_ip" {
  description = "Public IP of Vote/Result instance"
  value       = aws_instance.vote_result.public_ip
}

output "vote_result_private_ip" {
  description = "Private IP of Vote/Result instance"
  value       = aws_instance.vote_result.private_ip
}

output "redis_worker_private_ip" {
  description = "Private IP of Redis/Worker instance"
  value       = aws_instance.redis_worker.private_ip
}

output "postgres_private_ip" {
  description = "Private IP of PostgreSQL instance"
  value       = aws_instance.postgres.private_ip
}

output "vote_result_instance_id" {
  description = "Instance ID of Vote/Result"
  value       = aws_instance.vote_result.id
}

output "redis_worker_instance_id" {
  description = "Instance ID of Redis/Worker"
  value       = aws_instance.redis_worker.id
}

output "postgres_instance_id" {
  description = "Instance ID of PostgreSQL"
  value       = aws_instance.postgres.id
}