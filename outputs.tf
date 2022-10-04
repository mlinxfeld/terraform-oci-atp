output "FoggyKitchen_ATP_database_admin_password" {
   value = var.atp_password
}

output "FoggyKitchen_ATP_databases" {
  value    = data.oci_database_autonomous_databases.FoggyKitchen_ATP_databases.autonomous_databases
}

output "parallel_connection_string" {
  value    = [lookup(oci_database_autonomous_database.FoggyKitchen_ATP_primary_database.connection_strings.0.all_connection_strings, "PARALLEL", "Unavailable")]
}