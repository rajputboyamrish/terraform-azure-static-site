output "static_website_url" {
  value = azurerm_storage_account.site.primary_web_endpoint
  description = "URL of the static website"
}

