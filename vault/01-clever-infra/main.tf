resource "clevercloud_postgresql" "vault_storage" {
  name   = "vault_storage"
  plan   = "dev"
  region = "par"

  provisioner "local-exec" {
    command = "sleep 10 && psql -f vault-schema.sql"
    environment = {
      PGHOST     = self.host
      PGPORT     = self.port
      PGDATABASE = self.database
      PGUSER     = self.user
      PGPASSWORD = self.password
    }
  }
}

resource "clevercloud_docker" "vault_instance" {
  name = "vault_instance"

  # auto-scaling disabled
  smallest_flavor = "XS"
  biggest_flavor  = "XS"

  # auto-scaling disabled
  min_instance_count = 1
  max_instance_count = 1

  # network setup
  additional_vhosts = ["vault-instance.cleverapps.io"]
  redirect_https    = true
  sticky_sessions   = true

  # URL for the storage backend
  environment = {
    VAULT_LOCAL_CONFIG = jsonencode(
      {
        "storage" : {
          "postgresql" : {
            "connection_url" : "postgres://${clevercloud_postgresql.vault_storage.user}:${clevercloud_postgresql.vault_storage.password}@${clevercloud_postgresql.vault_storage.host}:${clevercloud_postgresql.vault_storage.port}/${clevercloud_postgresql.vault_storage.database}"
          }
        },
        "listener" : [{ "tcp" : { "address" : "0.0.0.0:8080", "tls_disable" : true } }],
        "disable_mlock" : true,
        "ui" : true
    })
  }
}
