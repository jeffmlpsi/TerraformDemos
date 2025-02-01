variable "container_name" {
  description = ""
  type = string
  default = "MyDummyApp"
}

output "container_name" {
  description = "value of the container name"
  value = var.container_name
}

variable "image_name" {
  description = ""
  type = string
  default = "dummy2"
}

variable "iport" {
  description = ""
  type = number
  default = 8081
}

variable "oport" {
  description = ""
  type = number
  default = 8081
}

