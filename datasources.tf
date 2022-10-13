data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "oci_database_autonomous_databases" "FoggyKitchen_ATP_databases" {
  provider       = oci.primaryregion
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = var.database_display_name
}
