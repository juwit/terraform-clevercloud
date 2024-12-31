resource "clevercloud_cellar" "this" {
  name = "tfstate"
}

resource "clevercloud_cellar_bucket" "backend_bucket" {
  cellar_id = clevercloud_cellar.this.id
  id        = "tfstate-bucket"
}