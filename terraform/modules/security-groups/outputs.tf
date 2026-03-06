output "vote_result_sg_id" {
  description = "ID of the Vote/Result security group"
  value       = aws_security_group.vote_result_sg.id
}

output "redis_worker_sg_id" {
  description = "ID of the Redis/Worker security group"
  value       = aws_security_group.redis_worker_sg.id
}

output "postgres_sg_id" {
  description = "ID of the PostgreSQL security group"
  value       = aws_security_group.postgres_sg.id
}