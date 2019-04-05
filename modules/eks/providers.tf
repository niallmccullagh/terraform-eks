#
# Not required: currently used in conjuction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-ip.tf for additional information.
#
provider "http" {
  version = "~> 1.0"
}

provider "external" {
  version = "~> 1.0"
}

data "aws_region" "current" {}

#
# The terraform kubernetes provider does not support the 'exec' authentication provider.
# The exec provider is required for aws, using heptio's authenticato, to retrieve a valid token.
# The authenticator.sh script grabs a token using heptio for the currently aws authenticated user.
# This enables the k8s configuration for the workers to be created and enable the workers to join 
# the cluster in a single terraform apply.
# https://github.com/terraform-providers/terraform-provider-kubernetes/issues/161
#
data "external" "aws-iam-authenticator" {
  program = ["bash", "${path.module}/authenticator.sh"]

  query {
    cluster_name = "${var.cluster_name}"
  }
}

#
# Initialise the k8s provider using details of the newly created cluster. 
#
provider "kubernetes" {
  version = "~> 1.1"
  host                   = "${aws_eks_cluster.eks.endpoint}"
  cluster_ca_certificate = "${base64decode(aws_eks_cluster.eks.certificate_authority.0.data)}"
  token                  = "${data.external.heptio_authenticator_aws.result.token}"
  load_config_file       = false
}