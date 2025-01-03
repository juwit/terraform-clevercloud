resource "gitlab_application" "oidc" {
  confidential = true
  scopes       = ["openid"]
  name         = "vault"
  redirect_url = "${var.vault_url}/ui/vault/auth/gitlab/oidc/callback"
}

resource "vault_jwt_auth_backend" "gitlab_oidc" {
  description         = "GitLab OIDC authentication"
  path                = "gitlab"
  type                = "oidc"
  # oidc_discovery_url  = var.gitlab_url
  oidc_client_id      = gitlab_application.oidc.application_id
  oidc_client_secret  = gitlab_application.oidc.secret
  bound_issuer        = var.gitlab_url
  tune {
    listing_visibility = "unauth"
  }
  default_role = "GitLab user"
}
