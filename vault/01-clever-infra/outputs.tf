output "vault_instance_id" {
  description = "Clever Cloud id for the instance. Use with `clever link` before deploying."
  value       = clevercloud_docker.vault_instance.id
}
