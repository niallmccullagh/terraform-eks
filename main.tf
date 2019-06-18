provider "aws" {
  version = ">= 1.24.0"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.11.7"
}

module "aws-vpc" {
  source = "./modules/aws-vpc"
  
  cluster_name = "${var.cluster_name}"
  availability_zones = "${var.availability_zones}"
}


module "eks" {
  source = "./modules/eks"
  
  cluster_name = "${var.cluster_name}"
  vpc_id = "${module.aws-vpc.vpc_id}"
  subnet_ids = "${module.aws-vpc.subnet_ids}"
  node_instance_type = "${var.node_instance_type}"
  number_of_nodes = "${var.number_of_nodes}"
  region = "${var.region}"
}
