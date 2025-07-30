output "web_instance_ip" {
  value = aws_instance.web.public_ip
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "web_instance_ip" {
  description = "Public IP address of the web EC2 instance"
  value       = aws_instance.web.public_ip
}