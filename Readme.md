# 🌐 AWS 3-Tier Architecture Terraform Project

## 📖 Overview

This project deploys a **3-tier architecture on AWS** using **Terraform** and **GitHub Actions**. The architecture consists of:

- **Presentation Layer** – Public subnet with EC2 instances behind an Application Load Balancer (ALB)
- **Application Layer** – EC2 instances in private subnets
- **Database Layer** – Amazon RDS (multi-AZ capable) hosted in isolated private subnets

This structure supports scalability, fault-tolerance, and maintainability using infrastructure-as-code (IaC).

---

### 📁 Project Structure

```
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── .terraform.lock.hcl
├── backend.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
└── README.md
```

| File/Directory                     | Description                                                                 |
|------------------------------------|-----------------------------------------------------------------------------|
| `.github/workflows/terraform.yml`  | GitHub Actions workflow for CI/CD automation                                |
| `main.tf`                          | Main infrastructure configuration (VPC, subnets, EC2, RDS, etc.)            |
| `variables.tf`                     | Input variable declarations                                                 |
| `outputs.tf`                       | Displays key outputs like ALB DNS and RDS endpoint                          |
| `provider.tf`                      | AWS provider configuration                                                  |
| `backend.tf`                       | Remote backend configuration (S3 + DynamoDB) for state management           |
| `.terraform.lock.hcl`              | Lock file to pin Terraform provider versions                                |
| `README.md`                        | This documentation file                                                     |

---

## ⚙️ GitHub Actions Automation

This project uses **GitHub Actions** to automate the deployment of AWS infrastructure using Terraform.

### 📋 Workflow Summary

- Runs on pushes and pull requests to `main`
- Uses **OIDC** to securely assume an AWS IAM role (no long-lived secrets)
- Performs:
  - `terraform fmt -check`
  - `terraform init`
  - `terraform validate`
  - `terraform plan`
  - (optional) `terraform apply` via manual approval or PR merge

Workflow file: `.github/workflows/terraform.yml`

For secure OIDC setup, see [GitHub OIDC to AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)

---

## ☁️ Remote State Management

Terraform state is securely stored in an **S3 bucket**, as defined in `backend.tf`.  
To prevent simultaneous state updates, **DynamoDB state locking** is used.

### Benefits:
- Reliable collaboration on shared infrastructure
- Versioned and encrypted state storage
- Protection against race conditions and partial state corruption

---

## 🚀 Deployment Instructions

### 1. 📦 Prerequisites

- [Terraform v1.6+](https://www.terraform.io/downloads.html)
- AWS credentials configured via:
  - AWS CLI (`aws configure`), **or**
  - GitHub Actions OIDC (recommended for CI/CD)

---

### 2. 🔁 Clone the Repository

```bash
git clone https://github.com/<your-org>/aws-3tier-terraform.git
cd aws-3tier-terraform
```

---

### 3. ⚙️ Initialize Terraform

```bash
terraform init
```
This downloads providers and connects to the remote backend.

---

### 4. 🛠 Customize Variables

Update `variables.tf` or create a `terraform.tfvars` file to configure:

- VPC CIDR
- EC2 instance types
- Key pair name
- DB settings (name, engine, instance class, etc.)

---

### 5. 🔍 Plan Infrastructure Changes

```bash
terraform plan
```
This previews the infrastructure that will be created or modified.

---

### 6. 🚢 Apply the Configuration

```bash
terraform apply
```
Confirm with `yes` to create all defined infrastructure.

---

## 🧪 Usage & Outputs

After successful deployment, `terraform apply` will output:

- ✅ Load Balancer DNS Name
- ✅ RDS Endpoint
- ✅ Subnet IDs, Security Groups, and more

You can use these in scripts or other Terraform modules.

---

## 🛡 Best Practices & Security

- ✅ Remote S3 state with encryption
- ✅ DynamoDB state locking
- ✅ GitHub OIDC + IAM role assumption (no static secrets)
- ✅ `.gitignore` excludes sensitive state files
- ✅ Minimal IAM permissions for CI role (least privilege)

---

## 📚 Additional Information

For more details on how to use Terraform, refer to the [Terraform Documentation](https://www.terraform.io/docs/index.html).

---

## 📝 License

This project is licensed under the MIT License. See the LICENSE file for more details.