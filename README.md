# 🚀 Terraform + Azure Static Website Deployment

This project demonstrates how to deploy a **static website** to **Azure Storage** using **Terraform** and automate the deployment with **GitHub Actions**.

---

## 📋 Prerequisites

Before starting, make sure you have:

- An **Azure subscription**
- A **GitHub account**
- Terraform installed or access to **Azure Cloud Shell**
- Permissions to create resources in Azure

---

## ⚙️ Step 1 — Set Up Terraform Files

In your repository, create the following files:

### `main.tf`

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = ">= 1.7.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-static-site-rg"
  location = "West India"
}

resource "azurerm_storage_account" "storage" {
  name                     = "tfstaticsite${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
```

---

## ☁️ Step 2 — Connect Cloud Shell to GitHub

```bash
git config --global user.name "Amrish Kumar"
git config --global user.email "your_email@example.com"
git init
git remote add origin https://github.com/<your-username>/terraform-azure-static-site.git
git add .
git commit -m "Initial commit"
git push -u origin main
```

If you get an authentication error, [use a Personal Access Token (PAT)](https://github.com/settings/tokens) instead of your password.
git remote set-url origin https://<YOUR_GITHUB_USERNAME>@github.com/<YOUR_GITHUB_USERNAME>/<YOUR_REPO_NAME>.git

---

## 🔐 Step 3 — Create Azure Credentials for GitHub Actions

In Azure Cloud Shell:

```bash
az ad sp create-for-rbac --name "terraform-github" --role="Contributor" --scopes="/subscriptions/<subscription-id>" --sdk-auth
```

Copy the JSON output and go to your GitHub repo → **Settings → Secrets and variables → Actions → New repository secret**

Name the secret: `AZURE_CREDENTIALS`  
Paste the JSON value.

---

## ⚡ Step 4 — Create GitHub Actions Workflow

Create a file: `.github/workflows/deploy.yml`

```yaml
name: Terraform Deploy to Azure

on:
  push:
    branches:
      - main

permissions:
  contents: read
  id-token: write

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.7.0

      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
```

---

## 🌐 Step 5 — Access Your Static Website

After deployment, go to the Azure Portal → Storage Account → **Static website** → find your **Primary Endpoint URL**.

Open it in your browser — your static site should be live 🎉

---

## 🧠 Troubleshooting

- **Role assignment failed:** You may not have permission to assign roles. Contact your Azure admin.
- **GitHub push error:** Use Personal Access Token instead of password.
- **Site not updating:** Re-run `terraform apply` or check your workflow logs.

---

## ✍️ Author

**Amrish Kumar**  
🌐 GitHub: [rajputboyamrish](https://github.com/rajputboyamrish)

---

✅ *This lab automates infrastructure deployment and integrates continuous delivery via GitHub Actions.*

