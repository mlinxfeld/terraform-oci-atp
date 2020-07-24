resource "oci_database_autonomous_database" "FoggyKitchen_ATP_database" {
  admin_password           = var.atp_password
  compartment_id           = oci_identity_compartment.FoggyKitchenCompartment.id
  cpu_core_count           = var.FoggyKitchen_ATP_database_cpu_core_count
  data_storage_size_in_tbs = var.FoggyKitchen_ATP_database_data_storage_size_in_tbs
  db_name                  = var.FoggyKitchen_ATP_database_db_name
  display_name             = var.FoggyKitchen_ATP_database_display_name
  freeform_tags            = var.FoggyKitchen_ATP_database_freeform_tags
  license_model            = var.FoggyKitchen_ATP_database_license_model
  is_data_guard_enabled    = false
#  is_free_tier             = true
}

data "oci_database_autonomous_databases" "FoggyKitchen_ATP_databases" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = var.FoggyKitchen_ATP_database_display_name
}

output "FoggyKitchen_ATP_database_admin_password" {
   value = var.atp_password
}

output "FoggyKitchen_ATP_databases" {
  value = data.oci_database_autonomous_databases.FoggyKitchen_ATP_databases.autonomous_databases
}

output "parallel_connection_string" {
  value = [lookup(oci_database_autonomous_database.FoggyKitchen_ATP_database.connection_strings.0.all_connection_strings, "PARALLEL", "Unavailable")]
}
