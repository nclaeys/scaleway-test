locals {
  project_id = "b8e0510f-f68b-4139-8356-9bd7c11164e8"
}

resource "scaleway_object_bucket" "dbt-test" {
  name       = "dbt-jaffle-shop"
  project_id = local.project_id
  tags = {
    terraform = "True"
  }
}

resource "random_string" "db-pass" {
  length      = 16
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
}

# By default creates a public endpoint, you can also only create a private endpoint if needed.
resource "scaleway_rdb_instance" "main" {
  name               = "test-dbt"
  node_type          = "DB-PLAY2-NANO"
  engine             = "PostgreSQL-15"
  is_ha_cluster      = false
  disable_backup     = true
  encryption_at_rest = true
  user_name          = "niels"
  password           = random_string.db-pass.result
  volume_type        = "sbs_5k"
  volume_size_in_gb  = 5
}

resource "scaleway_rdb_database" "main" {
  name        = "dbt"
  instance_id = scaleway_rdb_instance.main.id
}

resource "scaleway_rdb_privilege" "main" {
  instance_id   = scaleway_rdb_instance.main.id
  user_name     = "niels"
  database_name = scaleway_rdb_database.main.name
  permission    = "all"
}