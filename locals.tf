locals {
	emptyprimaryregion = var.primaryregion == "" ? var.region : var.primaryregion
    primaryregion = var.local_data_guard_enabled ? local.emptyprimaryregion : var.region
	standbyregion = var.remote_data_guard_enabled ? var.standbyregion : var.region
}