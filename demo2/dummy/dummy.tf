terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_container" "dummyapp" {
  image = "nginx"
  name = var.container_name

  ports {
    internal = var.iport
    external = var.oport
  }
}

output "container_id" {
  description = "value of the container id"
  value = docker_container.dummyapp.id
}
output "container_name" {
  description = "value of the container name"
  value = var.container_name
}

output "image_name" {
  description = "value of the image name"
  value = var.image_name
  
}

output "port_mappings" {
  value = "Container ${var.container_name} is mapped to ${var.iport}:${var.oport}"
}