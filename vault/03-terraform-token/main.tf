resource "vault_policy" "terraform" {
  name   = "terraform-policy"
  policy = file("terraform-policy.hcl")
}

resource "vault_token" "terraform_token" {
  display_name = "terraform-token"
  policies = ["terraform-policy"]
  renewable = false
}

output "terraform_token" {
  sensitive = true
  value = vault_token.terraform_token.client_token
}