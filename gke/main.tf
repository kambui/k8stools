terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name               = "my-preemptible-gke-cluster"
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  deletion_protection = false
  networking_mode          = "VPC_NATIVE"
  ip_allocation_policy {}
}

resource "google_container_node_pool" "preemptible_nodes" {
  name       = "preemptible-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-medium" # Cheap & balanced
    preemptible  = true        # <--- PREEMPTIBLE VMs

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
