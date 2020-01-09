# Terraform OCI ATP 

## Project description

In this repository, I have documented my hands on experience with Terrafrom for the purpose of OCI ATP deployment. This set of HCL based Terraform files whioch can customized according to any requirements.   

## How to use code 

### STEP 1.

Clone the repo from github by executing the command as follows and then go to terraform-oci-atp directory:

```
Martin-MacBook-Pro:~ martinlinxfeld$ git clone https://github.com/mlinxfeld/terraform-oci-atp.git
Cloning into 'terraform-oci-atp'...
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 16 (delta 0), reused 7 (delta 0), pack-reused 7
Unpacking objects: 100% (16/16), done.

Cloning into 'terraform-oci-atp'...
Martin-MacBook-Pro:~ martinlinxfeld$ cd terraform-oci-atp/
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ ls -latr
total 80
drwxrwxrwt  11 martinlinxfeld  wheel    352  8 sty 12:52 ..
-rw-r--r--   1 martinlinxfeld  wheel  14762  8 sty 12:52 README.md
-rw-r--r--   1 martinlinxfeld  wheel   1299  8 sty 12:52 atp.tf
-rw-r--r--   1 martinlinxfeld  wheel    619  8 sty 12:52 atp_wallet.tf
-rw-r--r--   1 martinlinxfeld  wheel    144  8 sty 12:52 compartment.tf
-rw-r--r--   1 martinlinxfeld  wheel    239  8 sty 12:52 provider.tf
drwxr-xr-x  10 martinlinxfeld  wheel    320  8 sty 12:52 .
-rw-r--r--   1 martinlinxfeld  wheel    861  8 sty 12:52 variables.tf
drwxr-xr-x  12 martinlinxfeld  wheel    384  8 sty 12:52 .git

```

### STEP 2.

Within web browser go to URL: https://www.terraform.io/downloads.html. Find your platform and download the latest version of your terraform runtime. Add directory of terraform binary into PATH and check terraform version:

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ export PATH=$PATH:/User/martinlinxfeld/terraform

Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ terraform --version

Terraform v0.12.16

Your version of Terraform is out of date! The latest version
is 0.12.17. You can update by downloading from https://www.terraform.io/downloads.html
```

### STEP 3. 
Next create environment file with TF_VARs (remember about your ATP password):

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ vi setup_oci_tf_vars.sh
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaob4qbf2(...)uunizjie4his4vgh3jx5jxa"
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaas(...)krj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_compartment_ocid="ocid1.tenancy.oc1..aaaaaaaasbktyckn(...)ldkrj2s3gdbz7d2heqzzxn7pe64ksbia"
export TF_VAR_fingerprint="00:f9:d1:41:bb:57(...)82:47:e6:00"
export TF_VAR_private_key_path="/tmp/oci_api_key.pem"
export TF_VAR_region="eu-frankfurt-1"
export TF_VAR_private_key_oci="/tmp/id_rsa"
export TF_VAR_public_key_oci="/tmp/id_rsa.pub"
export TF_VAR_atp_password='<your_atp_passowrd>'

Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ source setup_oci_tf_vars.sh
```

### STEP 4.
Run *terraform init* with upgrade option just to download the lastest neccesary providers:

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ terraform init -upgrade

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "oci" (hashicorp/oci) 3.54.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.null: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### STEP 5.
Run *terraform apply* to provision the content of this lesson (type **yes** to confirm the the apply phase):

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ terraform apply

An execution plan has been generated and is shown below.

data.oci_objectstorage_namespace.FoggyKitchen_ATP_database_backup_namespace: Refreshing state...
oci_identity_compartment.FoggyKitchenCompartment: Refreshing state... [id=ocid1.compartment.oc1..aaaaaaaagillnk(...)aa3gfgjzbudesm3tsq]
data.oci_database_autonomous_databases.FoggyKitchen_ATP_databases: Refreshing state...
oci_objectstorage_bucket.FoggyKitchen_ATP_database_backup_bucket: Refreshing state... [id=n/fr5tvfiq2xhq/b/backup_fkatpdb1]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.oci_database_autonomous_database_wallet.FoggyKitchen_ATP_database_wallet will be read during apply
  # (config refers to values not yet known)
 <= data "oci_database_autonomous_database_wallet" "FoggyKitchen_ATP_database_wallet"  {
      + autonomous_database_id = (known after apply)
      + content                = (known after apply)
      + id                     = (known after apply)
      + password               = (sensitive value)
    }

  # local_file.FoggyKitchen_ATP_database_wallet_file will be created
  + resource "local_file" "FoggyKitchen_ATP_database_wallet_file" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "path.module/foggykitchen_atp_wallet.zip"
      + id                   = (known after apply)
    }

  # oci_database_autonomous_database.FoggyKitchen_ATP_database will be created
  + resource "oci_database_autonomous_database" "FoggyKitchen_ATP_database" {
      + admin_password                                 = (sensitive value)
      + autonomous_container_database_id               = (known after apply)
      + clone_type                                     = (known after apply)
      + compartment_id                                 = "ocid1.tenancy.oc1..aaaaaaaasbktycknc4n4ja673cmnldkrj2s3gdbz7d2heqzzxn7pe64ksbia"
      + connection_strings                             = (known after apply)
      + connection_urls                                = (known after apply)
      + cpu_core_count                                 = 1
      + data_safe_status                               = (known after apply)
      + data_storage_size_in_tbs                       = 1
      + db_name                                        = "fkatpdb1"
      + db_version                                     = (known after apply)
      + db_workload                                    = (known after apply)
      + defined_tags                                   = (known after apply)
      + display_name                                   = "FoggyKitchenATP"
      + freeform_tags                                  = {
          + "Owner" = "FoggyKitchen"
        }
      + id                                             = (known after apply)
      + is_auto_scaling_enabled                        = (known after apply)
      + is_dedicated                                   = (known after apply)
      + is_free_tier                                   = (known after apply)
      + is_preview                                     = (known after apply)
      + is_preview_version_with_service_terms_accepted = (known after apply)
      + license_model                                  = "LICENSE_INCLUDED"
      + lifecycle_details                              = (known after apply)
      + service_console_url                            = (known after apply)
      + source                                         = (known after apply)
      + source_id                                      = (known after apply)
      + state                                          = (known after apply)
      + system_tags                                    = (known after apply)
      + time_created                                   = (known after apply)
      + time_deletion_of_free_autonomous_database      = (known after apply)
      + time_maintenance_begin                         = (known after apply)
      + time_maintenance_end                           = (known after apply)
      + time_reclamation_of_free_autonomous_database   = (known after apply)
      + used_data_storage_size_in_tbs                  = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

(...)
oci_database_autonomous_database.FoggyKitchen_ATP_database: Creating...
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still creating... [10s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still creating... [20s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still creating... [30s elapsed]

(...)

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

FoggyKitchen_ATP_database_admin_password = B(...)#11
FoggyKitchen_ATP_databases = [
  {
    "admin_password" = ""
    "autonomous_container_database_id" = ""
    "clone_type" = ""
    "compartment_id" = "ocid1.compartment.oc1..aaaaaaaajo(...)j2goxn6xcchpx4a"
    "connection_strings" = [
      {
        "all_connection_strings" = {
          "HIGH" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_high.atp.oraclecloud.com"
          "LOW" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_low.atp.oraclecloud.com"
          "MEDIUM" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_medium.atp.oraclecloud.com"
          "TP" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_tp.atp.oraclecloud.com"
          "TPURGENT" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_tpurgent.atp.oraclecloud.com"
        }
        "dedicated" = ""
        "high" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_high.atp.oraclecloud.com"
        "low" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_low.atp.oraclecloud.com"
        "medium" = "adb.ue-frankfurt-1.oraclecloud.com:1522/eo4tfsiqpxmhmow_fkatpdb1_medium.atp.oraclecloud.com"
      },
    ]
   (...)
    ]
    "cpu_core_count" = 1
    "data_safe_status" = "NOT_REGISTERED"
    "data_storage_size_in_tbs" = 1
    "db_name" = "fkatpdb1"
    "db_version" = "18c"
    "db_workload" = "OLTP"
    "defined_tags" = {}
    "display_name" = "FoggyKitchenATP"
    "freeform_tags" = {
      "Owner" = "FoggyKitchen"
    }
    "id" = "ocid1.autonomousdatabase.oc1.fra.abyhqlj(...)vjjs4h2bjr22dkxlogo3jq"
    "is_auto_scaling_enabled" = false
    "is_dedicated" = false
    "is_free_tier" = false
    "is_preview" = false
    "is_preview_version_with_service_terms_accepted" = false
    "license_model" = "LICENSE_INCLUDED"
    "lifecycle_details" = ""
    "service_console_url" = "https://adb.ue-frankfurt-1.oraclecloud.com/console/index.html?tenant_name=OCID1.TENANCY.OC1..AAAAAAAAWPQBLFEMTLUW(...)7EM7IFTKR3VD2R3A&database_name=FKATPDB1&service_type=ATP"
    "source" = ""
    "source_id" = ""
    "state" = "TERMINATED"
    "system_tags" = {}
    "time_created" = "2020-01-09 09:47:26.727 +0000 UTC"
    "time_deletion_of_free_autonomous_database" = ""
    "time_maintenance_begin" = "2020-01-12 04:00:00 +0000 UTC"
    "time_maintenance_end" = "2020-01-12 08:00:00 +0000 UTC"
    "time_reclamation_of_free_autonomous_database" = ""
    "used_data_storage_size_in_tbs" = 1
    "whitelisted_ips" = []
  },
]
parallel_connection_string = [
  "Unavailable",
]
wallet_password = [
  "AYGBp(...)3N+dno",
]
```

### STEP 6.
After testing the environment you can remove the ATP infra. You should just run *terraform destroy* (type **yes** for confirmation of the destroy phase):

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ terraform destroy

(...)
 # oci_database_autonomous_database.FoggyKitchen_ATP_database will be destroyed
  - resource "oci_database_autonomous_database" "FoggyKitchen_ATP_database" {
      - admin_password           = (sensitive value)
      - compartment_id           = "ocid1.compartment.oc1..aaaaaaaagillnk7ttj(...)maa3gfgjzbudesm3tsq" -> null
    (...)
        ] -> null
      - cpu_core_count           = 1 -> null
      - data_safe_status         = "NOT_REGISTERED" -> null
      - data_storage_size_in_tbs = 1 -> null
      - db_name                  = "fkatpdb1" -> null
      - db_version               = "18c" -> null
      - db_workload              = "OLTP" -> null
      - defined_tags             = {} -> null
      - display_name             = "FoggyKitchenATP" -> null
      - freeform_tags            = {
          - "Owner" = "FoggyKitchen"
        } -> null
      - id                       = "ocid1.autonomousdatabase.oc1.eu-frankfurt-1.abtheljrmw(...)7fzir6ru5kqwhx6tlgvqph46y6qhkjoma" -> null
      - is_auto_scaling_enabled  = false -> null
      - is_dedicated             = false -> null
      - is_free_tier             = false -> null
      - is_preview               = false -> null
      - license_model            = "LICENSE_INCLUDED" -> null
      - service_console_url      = "https://adb.eu-frankfurt-1.oraclecloud.com/console/index.html?tenant_name=OCID1.TENANCY.OC1..AAAAAAAASBKTYCKNC4N4JA673CMNL(...)QZZXN7PE64KSBIA&database_name=FKATPDB1&service_type=ATP" -> null
      - state                    = "AVAILABLE" -> null
      - system_tags              = {} -> null
      - time_created             = "2020-01-08 10:53:19.144 +0000 UTC" -> null
      - time_maintenance_begin   = "2020-01-11 11:00:00 +0000 UTC" -> null
      - time_maintenance_end     = "2020-01-11 15:00:00 +0000 UTC" -> null
      - whitelisted_ips          = [] -> null
    }

  # oci_identity_compartment.FoggyKitchenCompartment will be destroyed
  - resource "oci_identity_compartment" "FoggyKitchenCompartment" {
      - compartment_id = "ocid1.tenancy.oc1..aaaaaaaasbktycknc4n4(...)krj2s3gdbz7d2heqzzxn7pe64ksbia" -> null
      - defined_tags   = {} -> null
      - description    = "FoggyKitchen Compartment" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.compartment.oc1..aaaaaaaagillnk7t(...)xc5gbmrfxdtmaa3gfgjzbudesm3tsq" -> null
      - is_accessible  = true -> null
      - name           = "FoggyKitchenCompartment" -> null
      - state          = "ACTIVE" -> null
      - time_created   = "2019-12-02 19:22:17.767 +0000 UTC" -> null
    }

(...)

Plan: 0 to add, 0 to change, 4 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fz(...)tlgvqph46y6qhkjoma, 10s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fz(...)5kqwhx6tlgvqph46y6qhkjoma, 20s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fz(...)kqwhx6tlgvqph46y6qhkjoma, 30s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fz(...)kqwhx6tlgvqph46y6qhkjoma, 40s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fz(...)5kqwhx6tlgvqph46y6qhkjoma, 50s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Destruction complete after 57s
oci_identity_compartment.FoggyKitchenCompartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpi(...)mrfxdtmaa3gfgjzbudesm3tsq]
oci_identity_compartment.FoggyKitchenCompartment: Destruction complete after 0s

Destroy complete! Resources: 4 destroyed.

```
