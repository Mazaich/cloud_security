resource "yandex_compute_instance_group" "this" {
  name               = var.instance_name
  folder_id          = var.folder_id
  service_account_id = "aje6pskt4al62ksie4j8"

  instance_template {
    platform_id = var.platform_id

    resources {
      memory = var.memory
      cores  = var.cores
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.image_id
        size     = var.disk_size
        type     = var.disk_type
      }
    }

    network_interface {
      network_id = var.network_id
      subnet_ids = [var.subnet_id]
      nat        = true
    }

    metadata = {
      user-data = templatefile("${path.module}/user-data.sh", {
        image_url = var.image_url
      })
    }
  }

  scale_policy {
    fixed_scale {
      size = var.instance_count
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}

resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key"
  description       = "Ключ для шифрования бакета"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}

resource "yandex_iam_service_account_static_access_key" "storage_key" {
  service_account_id = "aje6pskt4al62ksie4j8"
  description        = "Ключ для доступа к бакету"
}

resource "yandex_storage_bucket" "static_site" {
  bucket     = "mashaev-static-site-2026"
  access_key = yandex_iam_service_account_static_access_key.storage_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage_key.secret_key

  acl = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "index" {
  bucket     = yandex_storage_bucket.static_site.bucket
  key        = "index.html"
  source     = "index.html"
  access_key = yandex_iam_service_account_static_access_key.storage_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage_key.secret_key
}

resource "yandex_storage_object" "error" {
  bucket     = yandex_storage_bucket.static_site.bucket
  key        = "error.html"
  source     = "error.html"
  access_key = yandex_iam_service_account_static_access_key.storage_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.storage_key.secret_key
}

output "bucket_website_url" {
  description = "URL статического сайта"
  value       = "http://${yandex_storage_bucket.static_site.website_domain}"
}

output "bucket_name" {
  description = "Имя бакета"
  value       = yandex_storage_bucket.static_site.bucket
}

output "kms_key_id" {
  description = "ID ключа KMS"
  value       = yandex_kms_symmetric_key.bucket_key.id
}
