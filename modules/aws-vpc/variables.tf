variable "number_of_subnets" {
  type    = "string"
  description = "Number of subnets to create"
  default = "2"
}

variable "cluster_name" {
  type    = "string"
  description = "Name to give the cluster"
}

variable "availability_zones" {
  type = "list"
  description = "List of az's to create the work node subets in"
}