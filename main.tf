provider "azurerm" {
  version = "=1.34.0"
}

variable "owner" {
  default = ""
}

variable "location" {
  default = ""
}

resource "azurerm_resource_group" "static_site_rg" {
  name     = "static-site-demo"
  location = var.location

  tags = {
    owner = var.owner
  }
}

resource "azurerm_storage_account" "static_site_asa" {
  name     = "staticsitestorageaccount"
  location = azurerm_resource_group.static_site_rg.location

  account_replication_type  = "RAGRS"
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  resource_group_name       = azurerm_resource_group.static_site_rg.name
  enable_https_traffic_only = true
  tags = {
    owner = var.owner
  }

  provisioner "local-exec" {
    command = <<EOF
az extension add --name storage-preview && \
az storage blob service-properties update \
    --account-name staticsitestorageaccount \
    --static-website \
    --404-document index.html \
    --index-document index.html
EOF

  }
}

