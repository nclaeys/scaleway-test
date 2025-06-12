
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
  private_network {
    pn_id = scaleway_vpc_private_network.private_1.id
    ip_net = "10.2.15.192/26" # last 64 IPs of the subnet
  }
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
