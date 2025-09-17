# Enable required APIs
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "storage" {
  project = var.project_id
  service = "storage.googleapis.com"
}

resource "google_project_service" "bigquery" {
  project = var.project_id
  service = "bigquery.googleapis.com"
}

# Unique suffix for the lab bucket (not the backend bucket)
resource "random_id" "bucket_suffix" {
  byte_length = 2
}

locals {
  lab_bucket_name = "lab-bucket-${var.project_id}-${random_id.bucket_suffix.hex}"
}

# 1) GCS bucket (lab resource)
resource "google_storage_bucket" "lab" {
  name                        = local.lab_bucket_name
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true

  depends_on = [google_project_service.storage]
}

# 2) BigQuery dataset
resource "google_bigquery_dataset" "lab" {
  dataset_id                 = var.bq_dataset_id
  location                   = var.bq_location
  delete_contents_on_destroy = true

  depends_on = [google_project_service.bigquery]
}

# 3) Compute Engine VM
resource "google_compute_instance" "lab_vm" {
  name         = var.vm_name
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${var.ssh_public_key}"
  }

  tags = ["ssh"]

  depends_on = [google_project_service.compute]
}
