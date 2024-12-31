output "postgresql_credentials" {
  value = {
    host     = clevercloud_postgresql.this.host
    port     = clevercloud_postgresql.this.port
    database = clevercloud_postgresql.this.database
    user     = clevercloud_postgresql.this.user
    password = clevercloud_postgresql.this.password
  }
}