variable "vpc_id" {
  type    = "string"
  description = "Id of the VPC to install the cluster in"
}

variable "cluster_name" {
  type    = "string"
  description = "Name to give the cluster"
}

variable "subnet_ids" {
  type    = "list"
  description = "List of subnets to install the cluster in"
}

variable "node_instance_type" {
  type = "string"
  description = "The aws instance type for the work nodes"
}

variable "number_of_nodes" {
  type    = "string"
  description = "Number of work nodes to create"
}

