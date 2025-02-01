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

output "port_mappings" {
  value = "Container ${var.container_name} is mapped to ${var.iport}:${var.oport}"
}