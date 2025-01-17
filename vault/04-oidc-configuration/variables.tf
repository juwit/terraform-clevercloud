variable "vault_url" {
  type        = string
  description = "Url of the Vault"
}

variable "gitlab_url" {
  type        = string
  description = "Url of the GitLab server"
}

variable "gitlab_application_id" {
  type        = string
  description = "Application ID of the GitLab application"
}

variable "gitlab_secret" {
  type        = string
  description = "Secret of the GitLab application"
}