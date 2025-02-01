variable "container_name" {
  description = ""
  type = string
  default = "MyDummyApp"
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

