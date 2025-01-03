terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.5.0"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.7.0"
    }
  }
}