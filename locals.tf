locals {
    primaryregion = var.local_data_guard_enabled ? var.primaryregion : var.region
	  standbyregion = var.remote_data_guard_enabled ? var.standbyregion : var.region
}