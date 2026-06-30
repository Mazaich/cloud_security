terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.135.0"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
  zone      = var.zone
  service_account_key_file = var.service_account_key_file
}
