output "cellar_keys" {
  sensitive = true
  value = {
    host       = clevercloud_cellar.this.host
    key_id     = clevercloud_cellar.this.key_id
    key_secret = clevercloud_cellar.this.key_secret
  }
}