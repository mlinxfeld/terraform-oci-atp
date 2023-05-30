locals {
    emptyprimaryregion            = var.primaryregion == "" ? var.region : var.primaryregion
    cross_region_enabled          = var.cross_region_disaster_recovery_enabled ? true : var.cross_region_disaster_recovery_enabled ? true : false  
    primaryregion                 = var.local_data_guard_enabled ? local.emptyprimaryregion : var.region
    standbyregion                 = local.cross_region_enabled ? var.standbyregion : var.region
    source                        = var.cross_region_disaster_recovery_enabled ? "CROSS_REGION_DISASTER_RECOVERY" : var.cross_region_data_guard_enabled ? "CROSS_REGION_DATAGUARD" : null
    remote_disaster_recovery_type = var.cross_region_disaster_recovery_enabled ? "BACKUP_BASED" :  var.cross_region_data_guard_enabled ? "ADG" : null
}
