resource "clevercloud_postgresql" "this" {
  name = "tf_pg"
  plan = "dev"
}