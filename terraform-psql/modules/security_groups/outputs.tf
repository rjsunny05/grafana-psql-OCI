output "lb_sg_id" {
  description = "ID of the load balancer security group"
  value       = aws_security_group.lb_sg.id
}

output "psql_sg_id" {
  description = "ID of the psql security group"
  value       = aws_security_group.psql_sg.id
}

output "g_sg_id" {
  description = "ID of the grafana security group"
  value       = aws_security_group.g_sg.id
}

output "jumphost_sg_id" {
  description = "ID of the jumphost security group"
  value       = aws_security_group.jumphost_sg.id
}