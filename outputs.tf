# ==============================
# OUTPUTS
# ==============================

# ALB DNS name
output "alb_dns" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}

# RDS Endpoint
output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.app_db.endpoint
}

# EC2 Instance ID (optional, helpful for debugging)
output "ec2_instance_id" {
  description = "ID of the EC2 instance running the Flask app"
  value       = aws_instance.app.id
}
