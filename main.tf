resource "azurerm_resource_group" "main" {
  name     = "amrish-terraform-rg"
  location = "East US"

  tags = {
    Environment = "Dev"
    Owner       = "Amrish Kumar"
  }
}

resource "azurerm_storage_account" "site" {
  name                     = "amrishterraformblob"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    Project = "Terraform Static Site"
    Owner   = "Amrish Kumar"
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.site.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "${path.module}/index.html"
  content_type           = "text/html"
}

