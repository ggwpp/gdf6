terraform {
  backend "gcs" {
    bucket = "grean-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  version = "3.5.0"

  project = "gdf6-274516"
  region  = "asia-northeast2"
  zone    = "asia-northeast2-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

