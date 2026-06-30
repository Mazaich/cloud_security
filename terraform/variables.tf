variable "folder_id" {
  description = "ID каталога в Yandex Cloud"
  type        = string
}

variable "image_id" {
  description = "ID образа LAMP"
  type        = string
  default     = "fd827b91d99psvq5fjit"
}

variable "network_id" {
  description = "ID сети"
  type        = string
  default     = "enp4vj9mk9g59eshqu1c"
}

variable "subnet_id" {
  description = "ID подсети"
  type        = string
  default     = "e9behqp5ikt8oihlcak6"
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "instance_count" {
  description = "Количество ВМ в группе"
  type        = number
  default     = 3
}

variable "instance_name" {
  description = "Имя группы ВМ"
  type        = string
  default     = "lamp-group"
}

variable "disk_size" {
  description = "Размер диска ВМ (ГБ)"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Тип диска"
  type        = string
  default     = "network-hdd"
}

variable "cores" {
  description = "Количество vCPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Объём RAM (ГБ)"
  type        = number
  default     = 2
}

variable "platform_id" {
  description = "Платформа ВМ"
  type        = string
  default     = "standard-v2"
}

variable "image_url" {
  description = "Ссылка на картинку в Object Storage"
  type        = string
  default     = "https://storage.yandexcloud.net/mashaev-24.06.2026/photo.jpg"
}

variable "service_account_key_file" {
  description = "Путь к файлу с ключом сервисного аккаунта"
  type        = string
  default     = "key.json"
}
