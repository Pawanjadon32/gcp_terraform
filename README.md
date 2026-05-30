# GCP VM - Terraform Setup

GCP par Terraform se VM banane ka complete setup.

---

## Prerequisites (Pehle ye karo)

1. **Terraform install karo** (v1.3+)
   ```bash
   # Linux/macOS
   brew install terraform
   # Ya official site se: https://developer.hashicorp.com/terraform/downloads
   ```

2. **Google Cloud SDK install karo**
   ```bash
   # https://cloud.google.com/sdk/docs/install
   gcloud auth application-default login
   ```

3. **GCP Project ready karo**
   ```bash
   gcloud projects create YOUR-PROJECT-ID
   gcloud config set project YOUR-PROJECT-ID
   
   # Required APIs enable karo
   gcloud services enable compute.googleapis.com
   gcloud services enable iam.googleapis.com
   ```

---

## File Structure

```
gcp-terraform-vm/
├── main.tf                   # Main resources (VM, Network, Firewall)
├── variables.tf              # Saare variables ki definition
├── outputs.tf                # Apply ke baad output values
├── terraform.tfvars.example  # Apni values ka template
└── .gitignore                # Sensitive files exclude karo
```

---

## Setup Steps

### Step 1: tfvars file banao
```bash
cp terraform.tfvars.example terraform.tfvars
# Ab terraform.tfvars mein apna project_id aur values bharo
```

### Step 2: SSH Key generate karo (agar nahi hai)
```bash
ssh-keygen -t rsa -b 4096 -C "your-email@example.com" -f ~/.ssh/gcp_key
# Public key copy karo:
cat ~/.ssh/gcp_key.pub
# Is value ko terraform.tfvars mein ssh_public_key mein paste karo
```

### Step 3: Terraform run karo
```bash
# Initialize
terraform init

# Plan dekho (kya banega preview)
terraform plan

# Apply karo (VM bana do)
terraform apply
```

### Step 4: VM se connect karo
```bash
# Output mein SSH command milega, ya:
gcloud compute ssh devuser@my-gcp-vm --zone=asia-south1-a

# Ya direct SSH se:
ssh -i ~/.ssh/gcp_key devuser@<EXTERNAL_IP>
```

---

## Machine Types Reference

| Type | vCPU | RAM | Use Case |
|------|------|-----|----------|
| e2-micro | 0.25 | 1 GB | Free tier, testing |
| e2-small | 0.5 | 2 GB | Light workloads |
| e2-medium | 1 | 4 GB | Dev server |
| e2-standard-2 | 2 | 8 GB | General purpose |
| n2-standard-4 | 4 | 16 GB | Production |

---

## VM Band Karna (Cost Bachao)

```bash
# Sirf stop karo (disk charges rahenge)
gcloud compute instances stop my-gcp-vm --zone=asia-south1-a

# Poora destroy karo (sab kuch delete)
terraform destroy
```

---

## Important Notes

- `terraform.tfvars` file ko **git mein mat daalo** (SSH keys hain)
- SSH source ranges mein **apna IP** lagao production mein: `["YOUR.IP/32"]`
- `e2-micro` machine type **free tier** mein aata hai (1 VM/month)
