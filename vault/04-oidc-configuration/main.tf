resource "vault_jwt_auth_backend" "gitlab_oidc" {
  description = "GitLab OIDC authentication"
  path        = "gitlab"
  type        = "oidc"

  oidc_discovery_url = var.gitlab_url
  oidc_client_id     = var.gitlab_application_id
  oidc_client_secret = var.gitlab_secret
  bound_issuer       = var.gitlab_url

  tune {
    listing_visibility = "unauth"
  }

  default_role = "gitlab-user"
}

resource "vault_jwt_auth_backend_role" "gitlab_user" {
  backend         = vault_jwt_auth_backend.gitlab_oidc.path
  role_name       = "gitlab-user"
  token_policies  = [vault_policy.read_secrets.name]

  user_claim            = "name"
  role_type             = "oidc"
  allowed_redirect_uris = ["${var.vault_url}/ui/vault/auth/${vault_jwt_auth_backend.gitlab_oidc.path}/oidc/callback"]
}

resource "vault_mount" "gitlab_secrets" {
  path        = "gitlab_users_secrets"
  type        = "kv"
  options = { version = "2" }
  description = "Secrets for the GitLab users"
}

resource "vault_policy" "read_secrets" {
  name = "read-secrets-policy"

  policy = <<EOT
# List, create, update, and delete key/value secrets at secret/
path "${vault_mount.gitlab_secrets.path}/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}

EOT
}