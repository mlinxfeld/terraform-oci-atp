resource "random_string" "wallet_password" {
  length  = 16
  special = true
}

data "oci_database_autonomous_database_wallet" "FoggyKitchen_ATP_database_wallet" {
  autonomous_database_id = oci_database_autonomous_database.FoggyKitchen_ATP_database.id
  password               = random_string.wallet_password.result
}

resource "local_file" "FoggyKitchen_ATP_database_wallet_file" {
  content  = data.oci_database_autonomous_database_wallet.FoggyKitchen_ATP_database_wallet.content
  filename = "path.module/foggykitchen_atp_wallet.zip"
}

output "wallet_password" {
  value = [random_string.wallet_password.result]
}
