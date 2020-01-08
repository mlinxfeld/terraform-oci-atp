# Terraform OCI ATP 

## Project description

In this repository, I have documented my hands on experience with Terrafrom for the purpose of OCI ATP deployment. This set of HCL based Terraform files whioch can customized according to any requirements.   

## How to use code 

### STEP 1.

Clone the repo from github by executing the command as follows and then go to terraform-oci-atp directory:

```
Martin-MacBook-Pro:~ martinlinxfeld$ git clone https://github.com/mlinxfeld/terraform-oci-atp.git
Cloning into 'terraform-oci-atp'...
remote: Enumerating objects: 121, done.
remote: Counting objects: 100% (121/121), done.
remote: Compressing objects: 100% (89/89), done.
remote: Total 258 (delta 73), reused 79 (delta 32), pack-reused 137
Receiving objects: 100% (258/258), 68.71 MiB | 23.28 MiB/s, done.
Resolving deltas: 100% (142/142), done.

Cloning into 'terraform-oci-atp'...
Martin-MacBook-Pro:~ martinlinxfeld$ cd terraform-oci-atp/
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ ls -latr
total 16
-rw-r--r--   1 martinlinxfeld  staff     657  8 sty 11:44 atp_backup.tf
-rw-r--r--   1 martinlinxfeld  staff     619  8 sty 11:44 atp_wallet.tf
-rw-r--r--   1 martinlinxfeld  staff     230  8 sty 11:44 provider.tf
drwxr-xr-x  12 martinlinxfeld  staff     384  8 sty 11:45 .git
drwxr-xr-x   5 martinlinxfeld  staff     160  8 sty 11:47 ..
-rw-r--r--   1 martinlinxfeld  staff     144  8 sty 11:48 compartment.tf
-rw-r--r--   1 martinlinxfeld  staff     861  8 sty 11:51 variables.tf
-rw-r--r--   1 martinlinxfeld  staff    1538  8 sty 11:53 atp.tf
-rw-r--r--@  1 martinlinxfeld  staff       0  8 sty 11:56 README.md

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
oci_identity_compartment.FoggyKitchenCompartment: Refreshing state... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
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

export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaob4qbf27tfijwcukep6yozaoywpueuunizjie4his4vgh3jx5jxa"
  # oci_database_autonomous_database_backup.FoggyKitchen_ATP_database_backup will be created
  + resource "oci_database_autonomous_database_backup" "FoggyKitchen_ATP_database_backup" {
      + autonomous_database_id = (known after apply)
      + compartment_id         = (known after apply)
      + database_size_in_tbs   = (known after apply)
      + display_name           = "backup_fkatpdb1"
      + id                     = (known after apply)
      + is_automatic           = (known after apply)
      + lifecycle_details      = (known after apply)
      + state                  = (known after apply)
      + time_ended             = (known after apply)
      + time_started           = (known after apply)
      + type                   = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

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

```

### STEP 6.
After testing the environment you can remove the infra. You should just run *terraform destroy* (type **yes** for confirmation of the destroy phase):

```
Martin-MacBook-Pro:terraform-oci-atp martinlinxfeld$ terraform destroy

(...)

(...)

 # oci_database_autonomous_database.FoggyKitchen_ATP_database will be destroyed
  - resource "oci_database_autonomous_database" "FoggyKitchen_ATP_database" {
      - admin_password           = (sensitive value)
      - compartment_id           = "ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq" -> null
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
      - id                       = "ocid1.autonomousdatabase.oc1.eu-frankfurt-1.abtheljrmwdfwt7poh6mhi7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma" -> null
      - is_auto_scaling_enabled  = false -> null
      - is_dedicated             = false -> null
      - is_free_tier             = false -> null
      - is_preview               = false -> null
      - license_model            = "LICENSE_INCLUDED" -> null
      - service_console_url      = "https://adb.eu-frankfurt-1.oraclecloud.com/console/index.html?tenant_name=OCID1.TENANCY.OC1..AAAAAAAASBKTYCKNC4N4JA673CMNLDKRJ2S3GDBZ7D2HEQZZXN7PE64KSBIA&database_name=FKATPDB1&service_type=ATP" -> null
      - state                    = "AVAILABLE" -> null
      - system_tags              = {} -> null
      - time_created             = "2020-01-08 10:53:19.144 +0000 UTC" -> null
      - time_maintenance_begin   = "2020-01-11 11:00:00 +0000 UTC" -> null
      - time_maintenance_end     = "2020-01-11 15:00:00 +0000 UTC" -> null
      - whitelisted_ips          = [] -> null
    }

  # oci_identity_compartment.FoggyKitchenCompartment will be destroyed
  - resource "oci_identity_compartment" "FoggyKitchenCompartment" {
      - compartment_id = "ocid1.tenancy.oc1..aaaaaaaasbktycknc4n4ja673cmnldkrj2s3gdbz7d2heqzzxn7pe64ksbia" -> null
      - defined_tags   = {} -> null
      - description    = "FoggyKitchen Compartment" -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq" -> null
      - is_accessible  = true -> null
      - name           = "FoggyKitchenCompartment" -> null
      - state          = "ACTIVE" -> null
      - time_created   = "2019-12-02 19:22:17.767 +0000 UTC" -> null
    }

(...)

Plan: 0 to add, 0 to change, 5 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma, 10s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma, 20s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma, 30s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma, 40s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Still destroying... [id=ocid1.autonomousdatabase.oc1.eu-frankfu...7dypp7fzir6ru5kqwhx6tlgvqph46y6qhkjoma, 50s elapsed]
oci_database_autonomous_database.FoggyKitchen_ATP_database: Destruction complete after 57s
oci_identity_compartment.FoggyKitchenCompartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaagillnk7ttj6wpdhmewpibpxc5gbmrfxdtmaa3gfgjzbudesm3tsq]
oci_identity_compartment.FoggyKitchenCompartment: Destruction complete after 0s

Destroy complete! Resources: 5 destroyed.

```
