output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "web_instance_ip" {
  value = aws_instance.web.public_ip
}
