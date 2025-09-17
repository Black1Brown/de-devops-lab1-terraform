output "lab_bucket_name" {
  value = google_storage_bucket.lab.name
}

output "bigquery_dataset" {
  value = google_bigquery_dataset.lab.dataset_id
}

output "vm_self_link" {
  value = google_compute_instance.lab_vm.self_link
}

output "vm_external_ip" {
  value = google_compute_instance.lab_vm.network_interface[0].access_config[0].nat_ip
}
