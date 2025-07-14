output "wordpress_dns" {
  value = module.vpc.load_balancer_dns
  description = "The DNS name of the Wordpress deployment."
}