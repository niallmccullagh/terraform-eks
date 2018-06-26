
variable "cluster_name" {
  type = "string"
  description = "Name to give the cluster"
}


variable "availability_zones" {
  type = "list"
  description = "List of az's to create the work node subets in"
}

variable "node_instance_type" {
  type = "string"
  description = "The aws instance type for the work nodes"
}

variable "number_of_nodes" {
  type    = "string"
  description = "Number of work nodes to create"
}
