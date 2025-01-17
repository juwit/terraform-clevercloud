terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}