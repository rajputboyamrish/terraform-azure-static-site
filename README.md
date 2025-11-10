# 🌐 Terraform Azure Static Website — Automated Deployment via GitHub Actions

## 📁 Repository Structure

```
.github/workflows/       → Contains the GitHub Actions workflow (deploy.yml)
.gitignore               → Ignores unnecessary Terraform or system files
index.html               → Static HTML page to host on Azure Blob Storage
main.tf                  → Main Terraform configuration (resources definition)
output.tf                → Outputs (e.g., website endpoint URL)
provider.tf              → Azure provider configuration
terraform.tfvars         → Variable values (like resource group name, location)
variable.tf              → Variable definitions used across Terraform files
README.md                → Documentation (this file)
```

---

## 🎯 **Lab Objective**

This project demonstrates Infrastructure-as-Code (IaC) using **Terraform** and **GitHub Actions** to:

1. Provision Azure resources (Resource Group + Storage Account).
2. Host a **static website** on Azure Blob Storage.
3. Automate deployment using **GitHub Actions** CI/CD pipeline.

---

## 🚀 **Steps to Run**

### **Step 1: Clone the Repository**

```bash
git clone https://github.com/rajputboyamrish/terraform-azure-static-site.git
cd terraform-azure-static-site
```

---

### **Step 2: Initialize Terraform**

```bash
terraform init
```

### **Step 3: Plan Infrastructure**

```bash
terraform plan
```

### **Step 4: Apply Configuration**

```bash
terraform apply -auto-approve
```

This will:
- Create a **Resource Group**
- Create a **Storage Account**
- Enable **Static Website Hosting**
- Upload `index.html` to Azure Blob Storage

---

## ⚙️ **GitHub Actions Workflow**

File: `.github/workflows/deploy.yml`

This workflow:
- Runs automatically on **push to main**
- Logs into Azure using your Service Principal credentials (stored as a GitHub secret)
- Executes Terraform commands:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`

### **Setup GitHub Secret**

In your repo:
1. Go to **Settings → Secrets and variables → Actions**
2. Click **New repository secret**
3. Add:
   - **Name:** `AZURE_CREDENTIALS`
   - **Value:** (Output from `az ad sp create-for-rbac` command)

Example:
```json
{
  "clientId": "xxxxx",
  "clientSecret": "xxxxx",
  "subscriptionId": "xxxxx",
  "tenantId": "xxxxx"
}
```

---

## 🌍 **Access the Website**

After a successful run, you’ll see the website endpoint in the Terraform output.

Example:
```
https://amrishterraformblob.z13.web.core.windows.net/
```

---

## 🏷️ **Tags for Cost Tracking**

All Azure resources are tagged automatically for easy cost management.

---

## 🧩 **Research Section**

### 🔹 Terraform vs Bicep

| Feature | Terraform | Bicep |
|----------|------------|-------|
| Language Type | HCL (cross-cloud) | ARM-based (Azure only) |
| Reusability | High | Moderate |
| State Management | Remote/Local | Managed by Azure |
| Learning Curve | Medium | Easy for Azure users |
| Best Use Case | Multi-cloud IaC | Azure-native deployments |

---

## 👤 **Author**
**Amrish Kumar**  
GitHub: [@rajputboyamrish](https://github.com/rajputboyamrish)

---

## ✅ **Deliverables**

- ✅ Working Terraform code  
- ✅ Successful GitHub Actions workflow  
- ✅ Deployed static website on Azure  
- ✅ Tagged resources for cost tracking  
- ✅ README.md (Documentation)

