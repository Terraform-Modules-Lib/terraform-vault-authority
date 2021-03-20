variable "name" {
  type = string
}

variable "description" {
  type = string
  default = ""
}

variable "path_prefix" {
  type = string
  default = ""
}

variable "parent_authority_path" {
  type = string
  default = ""
}

variable "urls_prefix" {
  type = set(string)
  default = []
}
