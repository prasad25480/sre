terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  

  project = "sre-bootcamp-328203"
  region  = "us-central1"
  zone    = "us-central1-a"
}
resource "google_container_cluster" "primary" {
  name     = "dr-cluster"
  location   = "us-central1-a"
  
  initial_node_count       = 4
 
  
    ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/14"
    services_ipv4_cidr_block = "/20"
  }
  
  
  
}


  
  




  





