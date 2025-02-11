output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "Name of the cloud storage bucket"
}

output "cluster" {
  value = {
    "client_certificate"     = google_container_cluster.domino_cluster.master_auth[0].client_certificate,
    "client_key"             = google_container_cluster.domino_cluster.master_auth[0].client_key,
    "cluster_ca_certificate" = google_container_cluster.domino_cluster.master_auth[0].cluster_ca_certificate,
    "cluster_ipv4_cidr"      = google_container_cluster.domino_cluster.cluster_ipv4_cidr,
    "name"                   = google_container_cluster.domino_cluster.name,
    "public_endpoint"        = google_container_cluster.domino_cluster.private_cluster_config[0].public_endpoint,
    "pod_cidr"               = google_compute_subnetwork.default.ip_cidr_range
  }
  description = "GKE cluster information"
}

output "dns" {
  value       = var.google_dns_managed_zone.enabled ? google_dns_record_set.a[0].name : ""
  description = "The external (public) DNS name for the Domino UI"
}

output "google_filestore_instance" {
  value = {
    file_share = !var.filestore_disabled ? google_filestore_instance.nfs[0].file_shares[0].name : "",
    ip_address = !var.filestore_disabled ? google_filestore_instance.nfs[0].networks[0].ip_addresses[0] : "",
  }
}

output "project" {
  value       = var.project
  description = "GCP project ID"
}

output "region" {
  value       = local.region
  description = "Region where the cluster is deployed derived from 'location' input variable"
}

output "static_ip" {
  value       = var.static_ip_enabled ? google_compute_global_address.static_ip[0].address : ""
  description = "The external (public) static IPv4 for the Domino UI"
}

output "uuid" {
  value       = local.uuid
  description = "Cluster UUID"
}

output "service_accounts" {
  value       = { for sa in local.service_accounts : sa => google_service_account.accounts[sa] }
  description = "GKE cluster Workload Identity namespace IAM service accounts"
}

output "domino_artifact_repository" {
  value = google_artifact_registry_repository.domino
}
