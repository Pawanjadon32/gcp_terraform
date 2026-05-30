terraform {
  backend "gcs" {
    bucket = "terraform-state-pawan-bucket"
    prefix = "vm"
  }
}
