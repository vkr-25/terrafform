resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content = "we love pets"
}

provider "google" {
  project = "tf-on-gcp-422105"
  credentials = "${file("credentials.json")}"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "tf-gcp-1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}