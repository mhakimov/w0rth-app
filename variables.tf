variable "marketing-users" {
  type = list(string)
  default = ["Alice", "Malory"]
}

variable "region" {
  type = string
  default = "eu-west-2"
}

variable "domain_name" {}
