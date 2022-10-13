variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "primaryregion" {}
variable "standbyregion" {}
variable "compartment_ocid" {}
variable "atp_password" {}

variable "database_cpu_core_count" {
  default = 1
}

variable "database_data_storage_size_in_tbs" {
  default = 1
}

variable "database_db_name" {
  default = "fkatpdb1"
}

variable "database_defined_tags_value" {
  default = "value"
}

variable "database_display_name" {
  default = "FoggyKitchenATP_primary"
}

variable "remote_standby_database_display_name" {
  default = "FoggyKitchenATP_remote_standby"
}

variable "database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "database_db_version" {
  default = "19c"
}

variable "remote_data_guard_enabled" {
  default = false
}

variable "local_data_guard_enabled" {
  default = false
}