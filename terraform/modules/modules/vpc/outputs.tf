output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_redis_id" {
  description = "ID of the private subnet for Redis/Worker"
  value       = aws_subnet.private_redis.id
}

output "private_subnet_db_id" {
  description = "ID of the private subnet for PostgreSQL"
  value       = aws_subnet.private_db.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.main.id
}