variable "project_id" {
  type    = string
  default = "de-devops-lab1"
}

variable "region" {
  type        = string
  description = "Compute/GCS region"
  default     = "europe-central2"
}

variable "zone" {
  type        = string
  description = "Compute zone"
  default     = "europe-central2-a"
}

# BigQuery often uses multi-region 'EU'; region is also fine if enabled.
variable "bq_location" {
  type        = string
  description = "BigQuery location (EU or specific region like europe-central2)"
  default     = "EU"
}

variable "bq_dataset_id" {
  type        = string
  description = "Dataset ID (lowercase, underscores)"
  default     = "lab_dataset"
}

variable "vm_name" {
  type    = string
  default = "lab-vm"
}

variable "ssh_username" {
  type    = string
  default = "student"
}

variable "ssh_public_key" {
  type        = string
  description = "Full line from ~/.ssh/id_ed25519.pub (or RSA)"
}
