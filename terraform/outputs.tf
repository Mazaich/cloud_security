output "instance_group_id" {
  description = "ID созданной группы ВМ"
  value       = yandex_compute_instance_group.this.id
}

output "instance_group_name" {
  description = "Имя группы ВМ"
  value       = yandex_compute_instance_group.this.name
}

output "instance_group_status" {
  description = "Статус группы ВМ"
  value       = yandex_compute_instance_group.this.status
}

output "instances_external_ips" {
  description = "Внешние (публичные) IP-адреса ВМ"
  value       = yandex_compute_instance_group.this.instances[*].network_interface[0].nat_ip_address
}

output "instances_internal_ips" {
  description = "Внутренние IP-адреса ВМ"
  value       = yandex_compute_instance_group.this.instances[*].network_interface[0].ip_address
}

output "instances_names" {
  description = "Имена созданных ВМ"
  value       = yandex_compute_instance_group.this.instances[*].fqdn
}

output "instance_ids" {
  description = "ID созданных ВМ"
  value       = yandex_compute_instance_group.this.instances[*].instance_id
}
