terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = "my-first-project"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}