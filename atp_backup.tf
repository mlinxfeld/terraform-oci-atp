data "oci_objectstorage_namespace" "autonomous_database_backup_namespace" {
}

resource "oci_objectstorage_bucket" "autonomous_database_backup_bucket" {
  compartment_id = "${var.compartment_ocid}"
  name = "${var.autonomous_database_backup_display_name}"
  namespace = "${data.oci_objectstorage_namespace.autonomous_database_backup_namespace.namespace}"  
}

resource "oci_database_autonomous_database_backup" "autonomous_database_backup" {
  autonomous_database_id = "${oci_database_autonomous_database.autonomous_database.id}"
  display_name           = "${var.autonomous_database_backup_display_name}"
}

