data "oci_objectstorage_namespace" "FoggyKitchen_ATP_database_backup_namespace" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
}

resource "oci_objectstorage_bucket" "FoggyKitchen_ATP_database_backup_bucket" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  name           = var.FoggyKitchen_ATP_database_backup_display_name
  namespace      = data.oci_objectstorage_namespace.FoggyKitchen_ATP_database_backup_namespace.namespace  
}

resource "oci_database_autonomous_database_backup" "FoggyKitchen_ATP_database_backup" {
  autonomous_database_id = oci_database_autonomous_database.FoggyKitchen_ATP_database.id
  display_name           = var.FoggyKitchen_ATP_database_backup_display_name
}

