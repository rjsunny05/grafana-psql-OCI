output "jumphost_id" {
  description = "ID of the jumphost instance"
  value       = aws_instance.jumphost.id
}



output "psql1_id" {
  description = "ID of the first psql instance"
  value       = aws_instance.psql1.id
}

output "psql2_id" {
  description = "ID of the second psql instance"
  value       = aws_instance.psql2.id
}

output "psql3_id" {
  description = "ID of the third psql instance"
  value       = aws_instance.psql3.id
}

output "psql4_id" {
  description = "ID of the fourth psql instance"
  value       = aws_instance.psql4.id
}

output "grafana1_id" {
  description = "ID of the first grafana instance"
  value       = aws_instance.grafana1.id
}

output "grafana2_id" {
  description = "ID of the second grafana instance"
  value       = aws_instance.grafana2.id
}