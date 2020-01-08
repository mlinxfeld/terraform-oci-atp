variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "atp_password" {}

variable "FoggyKitchen_ATP_database_cpu_core_count" {
  default = 1
}

variable "FoggyKitchen_ATP_database_data_storage_size_in_tbs" {
  default = 1
}

variable "FoggyKitchen_ATP_database_db_name" {
  default = "fkatpdb1"
}

variable "FoggyKitchen_ATP_database_backup_display_name" {
  default = "backup_fkatpdb1"
}

variable "FoggyKitchen_ATP_database_defined_tags_value" {
  default = "value"
}

variable "FoggyKitchen_ATP_database_display_name" {
  default = "FoggyKitchenATP"
}

variable "FoggyKitchen_ATP_database_freeform_tags" {
  default = {
    "Owner" = "FoggyKitchen"
  }
}

variable "FoggyKitchen_ATP_database_license_model" {
  default = "LICENSE_INCLUDED"
}

