locals {
  secrets_count = 5
}

resource "random_pet" "username" {
  count = local.secrets_count
}

resource "random_password" "password" {
  count  = local.secrets_count
  length = 16
}

resource "vault_kv_secret_v2" "secret" {
  count = local.secrets_count

  data_json = jsonencode({
    username = random_pet.username[count.index].id
    password = random_password.password[count.index].result
  })
  mount = vault_mount.gitlab_secrets.path
  name  = random_pet.username[count.index].id
}