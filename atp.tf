resource "oci_database_autonomous_database" "FoggyKitchen_ATP_primary_database" {
  provider                     = oci.primaryregion
  admin_password               = var.atp_password
  compartment_id               = oci_identity_compartment.FoggyKitchenCompartment.id
  cpu_core_count               = var.database_cpu_core_count
  data_storage_size_in_tbs     = var.database_data_storage_size_in_tbs
  db_name                      = var.database_db_name
  display_name                 = var.database_display_name
  license_model                = var.database_license_model
  db_version                   = var.database_db_version
  is_local_data_guard_enabled  = var.local_data_guard_enabled ? true : false
}

resource "oci_database_autonomous_database" "FoggyKitchen_ATP_remote_database" {
  count                        = var.remote_data_guard_enabled ? 1 : 0
  provider                     = oci.standbyregion
  source                       = "CROSS_REGION_DATAGUARD"
  source_id                    = oci_database_autonomous_database.FoggyKitchen_ATP_primary_database.id
  compartment_id               = oci_identity_compartment.FoggyKitchenCompartment.id
  cpu_core_count               = var.database_cpu_core_count
  data_storage_size_in_tbs     = var.database_data_storage_size_in_tbs
  db_name                      = var.database_db_name
  display_name                 = var.remote_standby_database_display_name
  license_model                = var.database_license_model
  db_version                   = var.database_db_version
}



