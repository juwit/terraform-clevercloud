provider "vault" {
  address = var.vault_url
}

provider "gitlab" {
  base_url = var.gitlab_url
}