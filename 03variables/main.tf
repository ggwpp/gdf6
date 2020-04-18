terraform {
  backend "gcs" {
    bucket = "grean-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  version = "3.5.0"
  
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "gdf6-vpc"
}

resource "google_compute_instance" "vm_instance" {
  name         = "gdf6-vm"
  machine_type = "f1-micro"

  metadata = {
    ssh-keys = "gdf6:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGJ5yglMxa67z203vYSChyVD8lnndyOyWtVbuAxHnSHPM8eK/a5UjeopgPuItL6dX5ixm/ZpZlmDi0Q9B6sX3wX3BfV+mtxKJpK360wNRib8j1msUUvxuXIFma48qBQ7Ac5IpMtkroRCY/RbM3VMV2coWn+y9Qu4u6iJIdPif0dw5uqnDTBkgMktu7jFpZuAFWMkUhSPCoUtBOpeSEijJMVV31DX/UFaAKq2ehlqL4d6KOP3In9X3N+trDHi6JeChRJHuZn/5SF4g/7MK6wM0bhsFRbMVLhvQV76bLFYfGcAeV5UOElabg+8OjfH3jRWa1wWZ61pBUGfn3/W3obPFWDO4ulErt9VdPA5X7A0g7YyHAmuaMw6Eovs/n2AriWYkR3UAPFkc0mb6HqEJOBdbzwtOrh/4yknWs/2+99d6TYbwK6LIYzrGqyDyoFZZLJ1fjp6kgLR49c48ND/o0bqqGUZj8RuoeCUM8A0kNY9YAiPsrxYhdOELPCjZdsZlW19oMSGkya5jldafRgcWoyiFR+KYPdcdBPF+S68LQ2AxHv2uNw+cOnYFX6Nv+LSDrU50DHg1ORZUietB/ebgwVcqeTw3zJN25RfYL7w9BGfu2SPxf1ZSDNarAZOV9gdF4phaHIvyT1RWY9q1XH0GHJZcrHDYAStsmqE78LtSEJ+r+ZQ== gdf6"
  }

  tags = ["allow-ssh"]
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_instance" "vm_instance_staging" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  
  metadata = {
    ssh-keys = "gdf6:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGJ5yglMxa67z203vYSChyVD8lnndyOyWtVbuAxHnSHPM8eK/a5UjeopgPuItL6dX5ixm/ZpZlmDi0Q9B6sX3wX3BfV+mtxKJpK360wNRib8j1msUUvxuXIFma48qBQ7Ac5IpMtkroRCY/RbM3VMV2coWn+y9Qu4u6iJIdPif0dw5uqnDTBkgMktu7jFpZuAFWMkUhSPCoUtBOpeSEijJMVV31DX/UFaAKq2ehlqL4d6KOP3In9X3N+trDHi6JeChRJHuZn/5SF4g/7MK6wM0bhsFRbMVLhvQV76bLFYfGcAeV5UOElabg+8OjfH3jRWa1wWZ61pBUGfn3/W3obPFWDO4ulErt9VdPA5X7A0g7YyHAmuaMw6Eovs/n2AriWYkR3UAPFkc0mb6HqEJOBdbzwtOrh/4yknWs/2+99d6TYbwK6LIYzrGqyDyoFZZLJ1fjp6kgLR49c48ND/o0bqqGUZj8RuoeCUM8A0kNY9YAiPsrxYhdOELPCjZdsZlW19oMSGkya5jldafRgcWoyiFR+KYPdcdBPF+S68LQ2AxHv2uNw+cOnYFX6Nv+LSDrU50DHg1ORZUietB/ebgwVcqeTw3zJN25RfYL7w9BGfu2SPxf1ZSDNarAZOV9gdF4phaHIvyT1RWY9q1XH0GHJZcrHDYAStsmqE78LtSEJ+r+ZQ== gdf6"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
