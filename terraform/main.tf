locals {
  project_id = "b8e0510f-f68b-4139-8356-9bd7c11164e8"
  region     = "nl-ams"
  zone_1     = "nl-ams-1"
  zone_2     = "nl-ams-2"
  zone_3     = "nl-ams-3"
  tags       = ["terraform", "demo"]
}

resource "scaleway_object_bucket" "dbt-test" {
  name       = "dbt-jaffle-shop"
  project_id = local.project_id
  tags = {
    terraform = "True"
  }
}
