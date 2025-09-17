# DevOps Module — GCP Terraform Lab

This repository provisions:
- 1 GCS bucket
- 1 BigQuery dataset
- 1 Compute Engine VM

Terraform **state** is stored remotely in a GCS bucket.

## How to run
```bash
cd terraform
terraform init -backend-config=backend.hcl
terraform plan -out=tf.plan
terraform apply -auto-approve tf.plan
# later:
terraform destroy -auto-approve

